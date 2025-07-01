#!/bin/bash

#Colours green, blue, yellow, lcyan, normal
#export COLOURS=('\033[32m' '\033[01;34m' '\e[1;33m' '\033[1;36m' '\e[0m')


function layout_us (){
	setxkbmap -layout us
}

# Функция для поиска слов с одной ошибкой
find_correct_word() {
    local input_word="$1"
    local dictionary=("$@")  # Остальные аргументы - это слова из словаря
    local suggestions=()

    for word in "${dictionary[@]}"; do
        if [ ${#word} -eq ${#input_word} ]; then
            # Считаем количество отличий
            local differences=0
            for ((i=0; i<${#word}; i++)); do
                if [ "${word:i:1}" != "${input_word:i:1}" ]; then
                    ((differences++))
                fi
            done
            if [ $differences -eq 1 ]; then
                suggestions+=("$word")		# no
            fi
        fi
    done

    # 
    if [ ${#suggestions[@]} -gt 0 ]; then
		SOFT=$(printf "%s\n" "${suggestions[@]}" | fzf --header="Возможно вы имели ввиду:" --reverse --no-info --preview 'bash -c "func2 {}"')
    else
        echo "Нет предложений."
    fi
}

f_translate(){
	b1=$(echo "$1" | sed 's/[[:cntrl:]]//g')
	b2=$(echo "$1" | tr -d '\t\n')

	w=60
	b3=$(echo "$b2" | fmt -w $w )

	echo "$(trans :ru -no-auto -b "$b3")"
}
export -f f_translate

func2(){
	a0=$(apt-cache show $(echo "$1" | awk '{print $1}'))					#получаем первое слово
    a1=$(echo "$a0" | sed '/^.\{,2\}\.$/d')									#удалить строки больше 3 символов содержащие точку
	a2=$(echo "$a1" | awk '!seen[$0]++')									#удалить дубликаты строк
	a3=$(echo "$a2" | awk '/^Description/{print ""; print; next} {print}')
	a4=$(echo "$a3" | awk '/^Description-md5:/{print ""; print; next} 1')
	echo "$a4"
	echo
	COLOURS=('\033[32m' '\033[01;34m' '\e[1;33m' '\033[1;36m' '\e[0m')
	echo -e "${COLOURS[0]}"Перевод"${COLOURS[4]}"
	a5=$(echo "$a4" | sed -n '/^Description/,/^Description-md5:/p')
	a6=$(echo "$a5" | sed '/Description-md5/d')
	a7=$(f_translate "$a6")
	echo "$a7"
}
export -f func2

func_install(){
	clear 
	#apt-cache search "$SOFT" | grep -w "$SOFT" | fzf --reverse --no-info --preview 'bash -c "func2 {}"'
	
	# Выполняем поиск и сохраняем результат
	RESULT=$(apt-cache search "$SOFT" | grep -w "$SOFT")

	# Проверяем количество найденных строк
	if [ -z "$RESULT" ]; then
		#если слово целиком не найдено, то ищем без "grep -w"
		apt-cache search "$SOFT" | fzf --reverse --no-info --preview 'bash -c "func2 {}"'
	else
		echo "$RESULT" | fzf --reverse --no-info --preview 'bash -c "func2 {}"'
	fi
	
	#тут пароль не просит (apt show) а обычно просит
	#apt search --names-only "$SOFT" | grep -w "$SOFT"
	#aptitude search "~n$SOFT"
	#aptitude search "~n$SOFT" | awk '{print $3}'
	#dictionary=($(apt-cache pkgnames))

#если нет предложений то не устанавливать ничего

	echo -e "Установка"

	#echo
	echo -e "\napt install $SOFT"			#лишн кавычки были тут
	su -c "apt install \"$SOFT\" -y" -

	setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle
	exit
}

main(){
	echo "Введите название программы для установки"
	#layout_us
	read SOFT
	SOFT=$(echo "$SOFT" | tr '[:upper:]' '[:lower:]')	# > /dev/null
	dictionary=($(apt-cache pkgnames))

	# проверяем есть ли введеная пользователем программа в списке пакетов. если есть вызваем установку
	for word in "${dictionary[@]}"; do
		if [ "${word}" == "${SOFT}" ]; then
			func_install
		fi
	done

	find_correct_word "$SOFT" "${dictionary[@]}"
	func_install

}

#main "$@"
main

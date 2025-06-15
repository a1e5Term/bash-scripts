#!/bin/bash

#если давно обновлялись
#sudo apt update

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

    # Выводим предложения в fzf
    if [ ${#suggestions[@]} -gt 0 ]; then
        #SOFT=$(printf "%s\n" "${suggestions[@]}" | fzf --header="Возможно вы имели ввиду:" --reverse --no-info --preview 'apt-cache search {+1} | grep -w {+1}')
        
        #SOFT=$(printf "%s\n" "${suggestions[@]}" | fzf --header="Возможно вы имели ввиду:" --reverse --no-info --preview 'apt-cache show {} | grep -w {}')
        
        SOFT=$(printf "%s\n" "${suggestions[@]}" | fzf --header="Возможно вы имели ввиду:" --reverse --no-info --preview 'apt-cache show {}')
        
        #apt-cache search "$SOFT" | grep -w "$SOFT"
        #SELECT_SOFT=$(echo "${suggestions[@]}" | tr ' ' '\n' | fzf)
        #tr ' ' '\n': Команда tr (translate) заменяет символы. В данном случае она заменяет все пробелы (' ') на символы новой строки ('\n').
    else
        echo "Нет предложений."
    fi
}

func_install(){
	#echo -e "\n$SOFT"
	
	apt-cache search "$SOFT" | grep -w "$SOFT"
	#apt-cache search "$SOFT" | grep -w "$SOFT" | fzf --reverse --no-info --preview 'apt-cache show {} | awk "{print $1}"'
	#apt-cache search "$SOFT" | grep -w "$SOFT" | fzf --reverse --no-info --preview 'apt-cache show {} | awk "{print $1}"'
	
	#apt-cache search "$SOFT" | grep -w "$SOFT" | fzf --reverse --no-info --preview '{} | awk "{print \$1}" | apt-cache show -'


	#apt search --names-only "$SOFT" | grep -w "$SOFT"
	#aptitude search "~n$SOFT"
	#aptitude search "~n$SOFT" | awk '{print $3}'
	#dictionary=($(apt-cache pkgnames))

    local arrey=()
    local arrey2=()

		#в массив
			#второй столбец если описание есть
			
		#В другой массим
			#второй столбец если описание нет
	echo
	#apt-cache show $SOFT
	echo -e "\napt install $SOFT"			#лишн кав были тут
	su -c "apt install \"$SOFT\" -y" -

	setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle
	exit
}

echo "Введите название программы для установки"
layout_us
read SOFT
clear
echo "$SOFT" | tr '[:upper:]' '[:lower:]' > /dev/null
#SOFT_ORIG="$SOFT"

dictionary=($(apt-cache pkgnames))

for word in "${dictionary[@]}"; do
	if [ "${word}" == "${SOFT}" ]; then
		func_install
	fi
done

find_correct_word "$SOFT" "${dictionary[@]}"

func_install

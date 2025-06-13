#!/bin/bash

function layout_us ()
{
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
        SELECT_SOFT=$(echo "${suggestions[@]}" | tr ' ' '\n' | fzf)
    else
        echo "Нет предложений."
    fi

}

echo "Введите название программы для установки"
layout_us
read SOFT
echo "$SOFT" | tr '[:upper:]' '[:lower:]' > /dev/null

dictionary=($(apt-cache pkgnames))
find_correct_word "$SOFT" "${dictionary[@]}"
echo
apt-cache search "$SELECT_SOFT"

echo -e "\napt install $SELECT_SOFT"			#лишн кав были тут

su -c "apt install \"$SELECT_SOFT\" -y" -

setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle

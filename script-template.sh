#!/bin/bash
clear
# =============================================

# 1. автоматически проверит существование файла сохранения скриптов
# (выберет )

# проверит наличие остальных файлов

# =============================================

#set -euo pipefail
#e остановка скрипта если в строке ошибка
#u остановка при появлении необъявленной переменной
#o pipefail остановка при обнаружении неизвестных команд

#для пошаговой отладки раскоментировать:
#trap 'echo "# $BASH_COMMAND";read' DEBUG

# там можно узнать ОС
. /etc/os-release

#if [ -f "$XDG_DOCUMENTS_DIR/IT/scripts_bash/colors.mb4.sh" ]; then
	#source ~/Documents/IT/scripts_bash/colors.mb4.sh
#else
	source ~/.local/bin/colors.mb4_.sh
	#echo "нет файла ~/Documents/IT/scripts_bash/colors.mb4.sh"
#fi

#в переменную нужно добавить результат поиска. путь к найденному файлу.

#добавить возможность вставить путь сохранения

#скопировать в буфер выделение
#a="$(xsel -oc)"
#a="$(xsel -o --clipboard-format=text/html)"
#a="$(xclip -o)"
	#не рб
	#a="$(xclip -selection clipboard)"
	#a=`xclip -selection clipboard`
	#a="$(xclip -o -selection c)"

#a="$(xsel -b -i)"		не рб
#a="$(xsel --input)"	не рб

#рб
#a=$(xclip -o)

#создание файла
tmppth=$(mktemp)
#echo $tmppth

#для копирования выделенногоs
if command -v xclip &> /dev/null; then
	#AI_чтобы в терминале команда не выводила ошибки_bash.html
	#xclip -o > $tmppth >/dev/null 2>&1
	xclip -o > $tmppth
	#echo "xclip"
elif [[ "$ID" == "gentoo" ]]; then
	qdbus org.kde.klipper /klipper getClipboardContents > $tmppth
	#echo "qdbus"
fi


#cat $tmppth

#не рб
#a=$(xclip -sel clip)
#a=$(xclip -o | xclip -selection clipboard)

#a=$(xsel --clipboard --input)

#echo `xclip -o`
#не рб
#echo -e "${YELLOW}$a${NORMAL}"

#покрасить вывод
tput setaf 11
cat $tmppth
#убрать цвет
tput sgr0

echo
echo

#на первове место
# -e    включить интерпретацию управляющих символов, перечисленных ниже
echo -e "${GREEN}Выберети ЯП:${NORMAL}"
echo "1 - sh"
echo "2 - py"
#-i значение по умолчанию
read -e -i 1 Lang

case $Lang in
	1)
	ext='sh'
	#нужно проверять пути
	PATH_BASH="$HOME/Documents/LEARN_04_IT_LINUX/LINUX/scripts_bash"
	if [[ -d "$PATH_BASH" ]]; then
		PATH_SAVE="$PATH_BASH"
	else
		echo
		echo -e "${RED}Не найден путь: $PATH_BASH"
		PATH_SAVE=$(find $HOME -type d -name "scripts_bash" -print -quit)
		echo PATH_SAVE= $PATH_SAVE
	fi
	
	firstString='#!/bin/bash'
	#trigger=1
	;;
	2)
	ext='py'

	if [[ -d "$XDG_DOCUMENTS_DIR/LEARN_WORK/05_python/scripts_python" ]]; then
		PATH_SAVE="$XDG_DOCUMENTS_DIR/LEARN_WORK/05_python/scripts_python"
	else
		echo
		echo -e "${RED}Не найден путь: $XDG_DOCUMENTS_DIR/LEARN_WORK/05_python/scripts_python ${NORMAL}"
		PATH_SAVE=$(find $HOME -type d -name "scripts_python" -print -quit)
	fi
	
#firstString='#!/usr/bin/env python'	не рб при запуске из терминала
	firstString='#!/usr/bin/python3'
	;;
esac

# ------------------------------------------------------------------------
# default_path="~/Documents/IT/scripts_bash"

# -p позволяет запросить ввод у пользователя с сообщением
# Запросить у пользователя путь сохранения
echo ""
echo -e "${GREEN}Введите путь сохранения (по умолчанию: ${YELLOW}${PATH_SAVE}${NORMAL}${GREEN}):${NORMAL}${NORMAL}"
read user_input

# -z проверяет, является ли строка пустой.

# показать код
ansi_code=$(printf "%d\n" "'$user_input")

if [ "$ansi_code" -ne 0 ]; then
	PATH_SAVE="$user_input"
fi

# if [ -z "$user_input" ]; then
#     PATH_SAVE="$default_path"
#     echo "$user_input"
#     printf "%d\n" "'$user_input"

# else


# echo "PATH_SAVE:"
# echo "$PATH_SAVE"

# ------------------------------------------------------------------------
echo ""

# ввод имени пока оно не будет уникальным --------------------------------
n=1
while [ $n == '1' ]; do
	#зеленый цвет
	tput setaf 2
	tput sgr0
	
	echo -e "${GREEN}Enter the script name: ${NORMAL}"
		#read -e -i $[ $RANDOM % 7777 + 7777 ] -p "Enter the script name: " sName
		read -e -i $[ $RANDOM % 7777 + 7777 ] sName
		
	sName=$(echo "$sName" | sed 's/ /_/g')

	#проверить путь это или имя
	#если путь
		#проверить есть ли файл с таким именем
	
	#если имя
	#проверят есть скрипт с таким именем или нет
	if [[ -e "${PATH_SAVE}/${sName}.${ext}" ]]; then
		#n=1
		echo "\"${PATH_SAVE}/${sName}.sh\" существует. Введите имя заново"
	else
		n=0
	fi
	echo "$sName"
done

#=======================================================
echo
echo -e "${GREEN}Вставить выделенное?${NORMAL}"
echo "1 - да"
echo "2 - нет"

#если файл пуст то авто нет иначе 1
read -e -i 2 selectt
echo select: $select
#case $selectt in
	#1)
	
	
	##exit
	#;;
	#2)
	##exit
	#;;
#esac


#========================================================
#проверяем есть ли "update-alternatives --list editor" в ОС

if ! update-alternatives --list editor > /dev/null 2>&1; then
	echo ""
	echo -e "${RED}update-alternatives: error: no alternatives for editor${NORMAL}"
	echo ""
else
	echo ""
	echo -e "${GREEN}Открыть в:${NORMAL}"
	update-alternatives --list editor | nl
	echo ""
	echo -e "${GREEN}Введите номер. По умолчанию передается номер geany или micro или 4 в систему:${NORMAL}"
		#это не рб
		#read -e -i 2 -p "${GREEN}Введите номер. По умолчанию цифра 2 передастся:${NORMAL}" NN

	#проверяем есть ли geany в системе
	if [ `update-alternatives --list editor | grep -w geany - ` ]; then
		#если есть, получаем его номер в update-alternatives --list editor
		string=`update-alternatives --list editor | grep -n -w geany - `
		geany_number=${string:0:1}
		#echo 1
		read -e -i $geany_number NN
	elif [ `update-alternatives --list editor | grep -w micro - ` ]; then
		#если есть, получаем его номер в update-alternatives --list editor
		string=`update-alternatives --list editor | grep -n -w micro - `
		micro_number=${string:0:1}
		#echo 2
		read -e -i $micro_number NN
	else
		#echo 3
		read -e -i 4 NN
	fi
fi

#grep -q
#Тихий; ничего не записывайте в стандартный вывод. Немедленный выход с нулевым статусом, если обнаружено какое-либо совпадение, даже если была обнаружена ошибка. Также смотрите опцию -s или --no-messages.




touch "${PATH_SAVE}/${sName}.${ext}"
echo "${PATH_SAVE}/${sName}.${ext}"

# echo "$PATH_SAVE/${sName}.${ext}"

echo "$firstString" >> "${PATH_SAVE}/${sName}.${ext}"
echo

if [[ $ext == "sh" ]]; then
	FILE="${PATH_SAVE}/${sName}.${ext}"

	echo "set -euo pipefail" >> "${PATH_SAVE}/${sName}.${ext}"

	echo "#e остановка скрипта если в строке ошибка" >> "$PATH_SAVE/${sName}.${ext}"
	echo "#u остановка при появлении необъявленной переменной" >> "$PATH_SAVE/${sName}.${ext}"
	echo "#o pipefail остановка при обнаружении неизвестных команд" >> "$PATH_SAVE/${sName}.${ext}"

	echo "" >> "$PATH_SAVE/${sName}.${ext}"

	cat >> "${FILE}" << 'MULTILINE-COMMENT'
#для пошаговой отладки раскоментировать:
# trap 'echo "# $BASH_COMMAND";read' DEBUG
MULTILINE-COMMENT

	echo "" >> "$PATH_SAVE/${sName}.${ext}"

	cat >> "${FILE}" << 'MULTILINE-COMMENT'
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	echo "Usage: `basename $0` file_name"
	exit 0
fi
MULTILINE-COMMENT

	cat >> "${FILE}" << 'MULTILINE-COMMENT'
# Проверяем, передан ли аргумент
if [ -z "$1" ]; then
    echo "Использование: $0 <путь_к_директории>"
    exit 1
fi
MULTILINE-COMMENT

	cat >> "${FILE}" << 'MULTILINE-COMMENT'
if [[ ! -d "$1" ]]; then
	backupDir="/media/sda1/debuser"
else
	backupDir="$1"
fi
MULTILINE-COMMENT


fi

	#---------------------------------------------------------------------------------------
	#Вставить выделенное?
	#"1 - да"
	#"2 - нет"

	if [[ selectt -eq 1 ]]; then
		cat $tmppth >> "${PATH_SAVE}/${sName}.${ext}" && notify-send "Script create"
		rm $tmppth
	fi
	#---------------------------------------------------------------------------------------


# 	echo "" >> "$PATH_SAVE/${sName}.${ext}"
# 	echo "" >> "$PATH_SAVE/${sName}.${ext}"
# 	echo "" >> "$PATH_SAVE/${sName}.${ext}"
# 	echo "" >> "$PATH_SAVE/${sName}.${ext}"


chmod +x "$PATH_SAVE/$sName.$ext"

#`update-alternatives --list editor | head -$NN | tail +$NN` "$PATH_SAVE/$sName.$ext"

#попробовать сократить код завернув это
#string2=`update-alternatives --list editor | head -$NN | tail +$NN`



#запускаем скрипт в редакторе <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

if ! [[ "$NN" =~ ^-?[0-9]+$ ]]; then
	#echo "Это строка, а не число."
	${NN} "$PATH_SAVE/$sName.$ext"
	exit
fi

if ! update-alternatives --list editor > /dev/null 2>&1; then
	#echo ": no alternatives for editor_2"


	while true; do
		# Запрашиваем у пользователя название текстового редактора
		[[ "$ID" == "gentoo" ]] && ED='kate'
		
		echo -e "${GREEN}Введите название текстового редактора${NORMAL} (для gentoo по умолчанию [${YELLOW}${ED}${NORMAL}]: "; read editor
# 		read -p "${GREEN}Введите название текстового редактора${NORMAL} (для gentoo по умолчанию [${YELLOW}${ED}${NORMAL}]: "  editor
		editor=${editor:-${ED}}
		
		#     -a включает readline. что позволеят пользоваться гор клавишами для редактирования ввода

		# Проверяем, установлен ли редактор
		if command -v "$editor" &> /dev/null; then
		#     echo "$editor установлен. Запускаем..."
			# Запускаем редактор в отдельной сессии
		#     setsid "$editor" &


		# #     if [ "$ID" = "gentoo" ]; then
		#         curTerminal='konsole'
		#     fi

			[[ "$ID" == "gentoo" ]] && curTerminal='konsole'
			#echo "${editor} ${PATH_SAVE}/${sName}.${ext}"
			#${editor} ${PATH_SAVE}/${sName}.${ext}		рб
			"$curTerminal" -e bash -c "${editor} \"${PATH_SAVE}/${sName}.${ext}\"; exec bash"
			
			break  # Выход из цикла, если редактор найден

		else
			echo "$editor не установлен. Пожалуйста, установите его и попробуйте снова."
		fi

	done



else
	#если выбран geany. то курсор на 3-ю строчку
	if [ $(update-alternatives --list editor | head -$NN | tail +$NN | grep -w geany - ) ]; then
		`update-alternatives --list editor | head -$NN | tail +$NN` +7 "$PATH_SAVE/$sName.$ext"
	else
		#echo "Это число."
		`update-alternatives --list editor | head -$NN | tail +$NN` "$PATH_SAVE/$sName.$ext"
	fi

	#exit
fi

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

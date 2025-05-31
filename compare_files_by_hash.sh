#!/bin/bash

<< 'MULTILINE-COMMENT'

DOUBLECMD#TOOLBAR#XMLDATA<?xml version="1.0" encoding="UTF-8"?>
<doublecmd>
  <Program>
    <Hint>compare_files_by_hash.sh LEFT_PANEL RIGHT_PANEL</Hint>
    <Command>compare_files_by_hash.sh "%pl" "%pr"</Command>
    <Params>%t1</Params>
  </Program>
</doublecmd>

MULTILINE-COMMENT

GREEN='\033[32m'	# зелёный цвет знаков
LRED='\033[1;31m'
NORMAL='\033[0m'	# Сброс цвета

checkfile(){
	if [ ! -f "$1" ]; then
		echo "Файл $1 не существует."
		exit
	else
		return 0
	fi
}

if [ "$#" -eq 2 ]; then
    FILE_1="$1"
	checkfile "$FILE_1"
    FILE_2="$2"
	checkfile "$FILE_2"
elif [ "$#" -ne 2 ] && [ "$#" -ne 0 ]; then
	echo "Должно быть 2 аргумента или 0"
	exit
elif [ "$#" -eq 0 ]; then
	while true; do
		read -p "Введите путь к файлу 1: " FILE_1
		checkfile "$FILE_1"
		[[ $? -eq 0 ]] && break
	done

	while true; do
		read -p "Введите путь к файлу 2: " FILE_2
		checkfile "$FILE_2"
		[[ $? -eq 0 ]] && break
	done
fi

HASH='sha512sum'
hash1=$($HASH "$FILE_1" | awk '{ print $1 }')
hash2=$($HASH "$FILE_2" | awk '{ print $1 }')

echo -e "\n1.\n$FILE_1"
echo $HASH:
echo $hash1

echo -e "\n2.\n$FILE_2"
echo $HASH:
echo -e "$hash2\n"

if [ "$hash1" == "$hash2" ]; then
	echo -e "${GREEN}Файлы идентичны.${NORMAL}"
else
	echo -e "${LRED}Файлы различаются.${NORMAL}"
fi

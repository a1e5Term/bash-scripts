#!/bin/bash

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

hash1=$(md5sum "$FILE_1" | awk '{ print $1 }')
hash2=$(md5sum "$FILE_2" | awk '{ print $1 }')

echo -e "\n1.\n$FILE_1"
echo md5sum:
echo $hash1

echo -e "\n2.\n$FILE_2"
echo md5sum:
echo -e "$hash2\n"

if [ "$hash1" == "$hash2" ]; then
#!	зеленым
    echo "Файлы идентичны."
else
#!	красным
    echo "Файлы различаются."
fi

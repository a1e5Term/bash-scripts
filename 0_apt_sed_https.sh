#!/bin/bash

DIRECTORY_1="/etc/apt/sources.list"
DIRECTORY_2="${DIRECTORY_1}.d"

if [ -f "$DIRECTORY_1" ]; then
	echo "есть $DIRECTORY_1"
	sudo sed -i '/https/!s/http:/https:/g' "$DIRECTORY_1" && echo "Выполнена замена на https в файле $DIRECTORY_1."
		#Эта команда гарантирует, что замена будет выполнена только в строках, которые еще не содержат «https». 
		#sed -i: Отредактируйте файл на месте.
		#/https/!: Эта часть команды означает «если строка не содержит 'https'».
		#s/http:/https:/g: Эта часть команды выполняет замену «http:» на «https:» во всей строке.
else
	echo "нет $DIRECTORY_1"
fi

# Заменить "http" на "https" во всех файлах
for file in $DIRECTORY_2/*; do
    if [[ -f "$file" ]]; then
		sudo sed -i '/https/!s/http:/https:/g' "$DIRECTORY_1" && echo "Выполнена замена на https в папке $DIRECTORY_2."
    fi
done

#! /bin/bash

SOFT='webp'

if [ ! command -v "$SOFT" >/dev/null 2>&1 ] ; then
	echo Install "$SOFT"
	sudo apt install webp
	if [ ! command -v "$SOFT" >/dev/null 2>&1 ] ; then
		exit 0
	fi
fi   

convrt(){
	#имя без расширения
	dwebp "$1" -o "${1%.*}".png && rm "$1"
}

#пустой или нет аргумент
if [ -z "$1" ]; then
    echo "Использование:"
    echo "$0 <путь_к_директории>"
    echo "$0 <файл>"
    exit 0
elif [ -f "$1" ]; then
	convrt "$1"
elif [ -d "$1" ]; then
	cd "$1"
	for FILE in *.webp
	do 
		#dwebp "$FILE" -o "$FILE".png && rm "$FILE"
		convrt "$FILE"
	done
	
fi


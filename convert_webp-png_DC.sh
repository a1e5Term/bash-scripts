#! /bin/bash
SOFT='webp'

if ! command -v "$SOFT" >/dev/null 2>&1 ; then
	echo Install "$SOFT"
	sudo apt install webp
fi   

#имя без расширения
dwebp "$1" -o "${1%.*}".png && rm "$1"

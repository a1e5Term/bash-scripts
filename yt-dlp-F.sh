#!/bin/bash

FILE=filefile.txt
PATHSAVE="$HOME/.local/bin/yt-dlp"

#Colours green, blue, yellow, lcyan, normal
COLOURS=('\033[32m' '\033[01;34m' '\e[1;33m' '\033[1;36m' '\e[0m')

function install (){
	SOFT="ffmpeg"

	if ! command -v "$SOFT" >/dev/null 2>&1 ; then
		echo -e ${COLOURS[0]}установка ${SOFT}${COLOURS[4]}
		su -c "apt install \"$SOFT\" -y" -
	fi  
}

function first () {

	[[ ! -x $PATHSAVE ]] &&	su -c "chmod a+rx \"$PATHSAVE\"" -

	LIST=()
	echo -e ${COLOURS[0]}вставить URL${COLOURS[4]}
	read URL
	echo
	#URL=https://rutube.ru/video/9db722aaa25c825774bfe94da6a4fd04/
	#LIST=$($PATHSAVE -F $URL | awk '/^-----------/{found=1; next} found')

	#HAT=$(yt-dlp -F https://rutube.ru/video/dd2592b46c214006056c3a4fc6cd0f08 | awk '/^ID/')
	#echo -e "   $HAT"

	#$PATHSAVE -F $URL | awk '/^-----------/{found=1; next} found' > $FILE
	#HAT=$(yt-dlp -F https://rutube.ru/video/dd2592b46c214006056c3a4fc6cd0f08 | awk '/^ID/')
	#$PATHSAVE -F $URL | awk 'NR>=7'
	SELECT=$($PATHSAVE -F $URL | awk 'NR>=7' | fzf --reverse --header-lines=2)
	#cat $FILE
}

function second () {
	#exit
	count=1  # Счетчик
	IFS=$'\n'
	#read -ra itemArray <<< "$LIST"  # Читаем строку в массив
	#cat $FILE
	# Читаем файл в массив
	#readarray -t itemArray < $FILE
	
	itemArray=()  # Инициализируем массив

	for item in $(cat $FILE); do
	#for item in $itemArray ; do
		#echo second

	#for var in $(cat $file)

	#for item in "${itemArray[@]}" ; do
		echo -e "${COLOURS[2]}$count. ${COLOURS[4]}$item"  # Выводим номер и элемент
		#echo "$item"
		itemArray+=("$item")  # Добавляем каждую строку в массив

		((count++))  # Увеличиваем счетчик
	done
	echo

	## Выводим элементы массива
	#for item in "${itemArray[@]}"; do
		#echo "$item"
	#done
}

function tree ()
{
	echo -e "${COLOURS[0]}ввод${COLOURS[4]}"
	read a
	PART=$(echo "${itemArray[$a]}" | awk '{print $1}')
}

function four ()
{
	#echo $PART
	$PATHSAVE -f $PART -o "$HOME/Videos/%(title)s.%(ext)s" $URL
}

function main (){
	install
	first
	#second
	tree
	four
	rm $FILE
}

#не рб
#curl -L $URL -o $PATHSAVE/yt-dlp
#chmod a+rx $PATHSAVE/yt-dlp

main

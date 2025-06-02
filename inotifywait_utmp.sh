#!/bin/bash

instll(){
	if command -v "$1" >/dev/null 2>&1; then
		echo "install $1"
		su -c "apt install \"$1\" -y" -
			#Мы используем двойные кавычки вокруг всей команды, чтобы оболочка могла интерпретировать переменную $SOFT.
			#Внутри двойных кавычек мы экранируем переменную $SOFT с помощью обратной косой черты (\), чтобы избежать ее интерпретации до передачи команды в su.
	
		if command -v "$1" >/dev/null 2>&1; then
			exit 0
		fi
	fi    
}

dt(){
	date +"%Y-%m-%d %H-%M-%S"
}

who_grep(){
	who | grep -E 'pts|tty|console' | awk '{print $1, $2, $5}'
}

instll "inotify-tools"

s=2
echo -e "watching -e modify /var/run/utmp"
echo

while true; do
	echo 1. $(dt)
	who_grep
	echo
	
	while inotifywait -e modify /var/run/utmp >/dev/null 2>&1; do
		#notify-send -u critical -t 3600000 "изменение количества пользователей"
		zenity --info --text="modify /var/run/utmp"
		echo $s. $(dt)
		who_grep
		echo
		s=s+1
	done
done

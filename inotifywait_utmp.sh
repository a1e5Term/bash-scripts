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

setup_terminal() {
	# Setup the terminal for the TUI.
    # '\e[?1049h': Use alternative screen buffer.
    # '\e[?7l':    Disable line wrapping.
    # '\e[?25l':   Hide the cursor.
    # '\e[2J':     Clear the screen.
    printf '\e[?1049h\e[?7l\e[?25l\e[2J'

    # Hide echoing of user input
    stty -echo
}

who_grep(){
	#who | grep -E 'pts|tty|console' | awk '{print $1, $2, $5}'
	#w | grep -E 'pts|tty|console' | awk '{print $1, $2, $5}'
	
#?	шапку
	w | grep -E 'pts|tty|console'
}

instll "inotify-tools"

setup_terminal

s=2
echo -e "watching -e modify /var/run/utmp"
echo

while true; do
	echo 1. $(dt)
	who_grep
	echo
	
	while inotifywait -e modify /var/run/utmp >/dev/null 2>&1; do
		#notify-send -u critical -t 3600000 "изменение количества пользователей"
		echo $s. $(dt)
		who_grep
		zenity --info --text="modify /var/run/utmp"
		echo
		let s=s+1
	done
done

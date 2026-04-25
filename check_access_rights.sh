#!/bin/bash

#проверка и изменение прав доступа к  "~/.gnupg" если они не правильные
#потом добавить ввести путь

#=========================================================
BOLD='\033[1m'
GREEN="${BOLD}\033[32m"
RED="${BOLD}\033[31m"
NORMAL='\033[0m'
#=========================================================

clear

#C_PATH="~/.gnupg"	с кавычками не рб
C_PATH=~/.gnupg
SSH_PATH=~/.ssh

check () {
	#проверяем права доступа к папке CUR_DIR
	if [ ! "$(stat -c "%a" "$1")" -eq 700 ]; then
		#echo "Права доступа не равны 700."
		printf "%-30s ${RED}%s${NORMAL}\n" "$(basename "$1")" "$(stat -c "%a" "$1")"
	else
		#echo "Права доступа $1 равны 700."
		printf "%-30s ${GREEN}%s${NORMAL}\n" "$(basename "$1")" "$(stat -c "%a" "$1")"
	fi
#read
	echo

	#проверяем права доступа к папкам в папке CUR_DIR
	for item in $1/*; do 
		if [ -d "$item" ]; then
			if [ ! "$(stat -c "%a" $item)" -eq 700 ]; then
				#echo "Права доступа $item не равны 700."
				printf "%-30s ${RED}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
				 #$(ls -l "$item" | awk '{print $3}')

				#chmod 700 "$item" > /dev/null 2>&1
			else
				#echo "Права доступа $item равны 700."
				printf "%-30s ${GREEN}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
				 #$(ls -l "$item" | awk '{print $3}')
			fi
		fi
	done

	echo 

	#проверяем права доступа к файлам в папке C_PATH=~/.gnupg
	for item in $1/*; do 			
		if [ -f "$item" ]; then
			if [ ! "$(stat -c "%a" $item)" -eq 600 ]; then
				#echo "Права доступа $item не равны 600."
				printf "%-30s ${RED}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
				 #$(ls -l "$item" | awk '{print $3}')

				#chmod 600 "$item" > /dev/null 2>&1
			else
				#echo "Права доступа $item равны 600."
				printf "%-30s ${GREEN}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
				 #$(ls -l "$item" | awk '{print $3}')
			fi
		fi
	done
}

change (){
	#echo echo $1

	#C_PATH=~/.gnupg
	if [ ! "$(stat -c "%a" $1)" -eq 700 ]; then
		chmod 700 $1 > /dev/null 2>&1
		#printf "%-30s ${GREEN}%s${NORMAL}\n" "$(basename "$1")" "$(stat -c "%a" "$1")"
	fi
	
	echo
	
	for item in $1/*; do 
		if [ -d "$item" ]; then
			if [ ! "$(stat -c "%a" $item)" -eq 700 ]; then
				#echo "Права доступа $item не равны 600."
				chmod 700 "$item" > /dev/null 2>&1
				#printf "%-30s ${GREEN}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
				 #$(ls -l "$item" | awk '{print $3}')
			fi
		elif [ -f "$item" ]; then
			if [ ! "$(stat -c "%a" $item)" -eq 600 ]; then
				chmod 600 "$item" > /dev/null 2>&1
				#printf "%-30s ${GREEN}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
			fi
		fi
	done
	
	check "$CUR_DIR"
}

select_dir (){

	echo "Что проверить? 1 - $C_PATH / 2 - $SSH_PATH" 
	read CHOISE

	case $CHOISE in 
		1)
			CUR_DIR="$C_PATH"
			;;
		2)
			CUR_DIR="$SSH_PATH"
			;;
		*)
			echo "Неверный ввод"
			exit
			;;
	esac

}

select_dir

check "$CUR_DIR"

echo
echo "Исправить? 1 - да / 2 - нет"
read CHOISE
case $CHOISE in 
	1)
		change "$CUR_DIR"
		;;
	2)
		exit
		;;
	*)
		echo "Неверный ввод"
		exit
		;;
esac

#=========================================================

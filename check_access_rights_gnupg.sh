#!/bin/bash

#изм прав если они не правильные

#=========================================================
BOLD='\033[1m'
GREEN="${BOLD}\033[32m"
RED="${BOLD}\033[31m"
NORMAL='\033[0m'
#=========================================================

clear
C_PATH=~/.gnupg

check () {
	if [ ! "$(stat -c "%a" $C_PATH)" -eq 700 ]; then
		#echo "Права доступа не равны 700."
		printf "%-30s ${RED}%s${NORMAL}\n" "$(basename "$C_PATH")" "$(stat -c "%a" "$C_PATH")"
	else
		#echo "Права доступа $C_PATH равны 700."
		printf "%-30s ${GREEN}%s${NORMAL}\n" "$(basename "$C_PATH")" "$(stat -c "%a" "$C_PATH")"
	fi

	echo

	for item in $C_PATH/*; do 
		if [ -d "$item" ]; then
			if [ ! "$(stat -c "%a" $item)" -eq 700 ]; then
				#echo "Права доступа $item не равны 600."
				printf "%-30s ${RED}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
				 #$(ls -l "$item" | awk '{print $3}')

				#chmod 700 "$item" > /dev/null 2>&1
			else
				#echo "Права доступа $item равны 600."
				printf "%-30s ${GREEN}%s${NORMAL} %s\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
				 #$(ls -l "$item" | awk '{print $3}')
			fi
		fi
	done

echo 

	for item in $C_PATH/*; do 			
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
	C_PATH=~/.gnupg
	if [ ! "$(stat -c "%a" $C_PATH)" -eq 700 ]; then
		chmod 700 ~/.gnupg > /dev/null 2>&1
		#printf "%-30s ${GREEN}%s${NORMAL}\n" "$(basename "$C_PATH")" "$(stat -c "%a" "$C_PATH")"
	fi
	
	echo
	
	for item in $C_PATH/*; do 
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
	
	check
}

check

echo
echo Исправить? 1 -да /2 - нет
read CHOISE
case $CHOISE in 
	1)
		change
		;;
	2)
		exit
		;;
	*)
		echo Неверный ввод
		exit
		;;
esac

#=========================================================

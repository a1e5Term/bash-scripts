#!/bin/bash
clear
#=========================================================
BOLD='\033[1m'
GREEN="${BOLD}\033[32m"
RED="${BOLD}\033[31m"
NORMAL='\033[0m'

#=========================================================

if [ "$EUID" -ne 0 ]; then
	echo -e "${RED}для имзениения прав нужны права root${NORMAL}\n"
fi

#=========================================================
#изм прав если они не правильные...
	#... у папки ~/.gnupg
C_PATH=~/.gnupg
if [ ! "$(stat -c "%a" $C_PATH)" -eq 700 ]; then
    #echo "Права доступа не равны 700."
    printf "%-30s ${RED}%s${NORMAL}\n" "$(basename "$C_PATH")" "$(stat -c "%a" "$C_PATH")"
    chmod 700 ~/.gnupg > /dev/null 2>&1
else
    #echo "Права доступа $C_PATH равны 700."
    printf "%-30s ${GREEN}%s${NORMAL}\n" "$(basename "$C_PATH")" "$(stat -c "%a" "$C_PATH")"
fi
echo
	
	#... у всего что внутри папки ~/.gnupg
for item in $C_PATH/*; do 
	if [ ! "$(stat -c "%a" $item)" -eq 600 ]; then
		#echo "Права доступа $item не равны 600."
		printf "%-30s ${RED}%s${NORMAL}\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
		chmod 600 "$item" > /dev/null 2>&1
	else
		#echo "Права доступа $item равны 600."
		printf "%-30s ${GREEN}%s${NORMAL}\n" "$(basename "$item")" "$(stat -c "%a" "$item")"
	fi
done

#=========================================================

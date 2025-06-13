#!/bin/bash

function layout_us ()
{
	setxkbmap -layout us
}

echo "Введите название программы для установки"
read SOFT
echo "$SOFT" | tr '[:upper:]' '[:lower:]' > /dev/null
#echo "$SOFT" | tr '[:upper:]' '[:lower:]' > /dev/null
echo
apt-cache search "$SOFT"
#echo
read a
echo -e "\napt install \"$SOFT\""

layout_us

su -c "apt install \"$SOFT\" -y" -

setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle

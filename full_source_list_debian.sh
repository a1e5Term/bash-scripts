#!/bin/bash
#скрипт установит полный source list debian bookworm

CPATH="/etc/apt/sources.list.d"
sudo mkdir -p $CPATH

FILE="source_full_debian.list"

[[ -f $CPATH/$FILE ]] && sudo mv $CPATH/$FILE $CPATH/~$FILE

# Использование heredoc для записи в файл
cat <<EOL > $CPATH/$FILE
deb https://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

deb https://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware

deb https://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian/ bookworm-backports main contrib non-free non-free-firmware

deb https://security.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src https://security.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

deb https://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
EOL

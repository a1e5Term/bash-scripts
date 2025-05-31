#!/bin/bash

#------------------------------------------------------------
#Обновление Debian 11 до 12 Bookworm
#------------------------------------------------------------

CDATE=$(date +"%Y-%m-%d_%H-%M-%S")
dpkg --get-selections "*" > ~/dpkg_short_$CDATE.list
dpkg -l > ~/dpkg-full_$CDATE.list
sudo apt update
sudo apt upgrade 
sudo apt dist-upgrade
mkdir -p /etc/apt/sources.list.d
# apt --purge autoremove
# lsb_release -a
# cat /etc/debian_version
#apt list '?narrow(?installed, ?not(?origin(Debian)))'
	
#Обновляем файл с репозиториями /etc/apt/sources.list, изменив релиз с bullseye на bookworm
source ./full_source_list_debian.sh

sudo apt update
#apt -o APT::Get::Trivial-Only=true full-upgrade
sudo apt full-upgrade
sudo systemctl reboot

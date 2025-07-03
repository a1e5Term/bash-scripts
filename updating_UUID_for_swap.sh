#!/bin/bash

# Получаем строку с информацией о swap
swap_info=$(lsblk -f | grep swap)

# Извлекаем название устройства
if [ -n "$swap_info" ]; then
	device_name=$(echo $swap_info | awk '{print $1}' | sed 's/[^a-zA-Z0-9]*//g')
	uuid=$(lsblk -o UUID -n /dev/"$device_name")
    
    echo "Название устройства для swap: $device_name"
    echo "UUID устройства: $uuid"

    echo "Название устройства для swap: $device_name"
else
    echo "Swap устройство не найдено."
fi

sudo sed -i "/swap/s/UUID=[^ ]*/UUID=$uuid/" /etc/fstab
	#sed -i: редактирует файл на месте.
	#/swap/: указывает, что замена должна происходить только в строках, содержащих слово "swap".
	#s/UUID=[^ ]*/UUID=NEW_UUID/: заменяет найденный UUID на NEW_UUID. Здесь [^ ]* соответствует любому значению UUID, состоящему из символов, не являющихся пробелами.

sudo swapon /dev/"$device_name"

#!/bin/bash

hash1=$(md5sum "$1" | awk '{ print $1 }')
hash2=$(md5sum "$2" | awk '{ print $1 }')

echo "$1"
echo md5sum:
echo $hash1

echo -e "\n$2"
echo md5sum:
echo -e "$hash2\n"

if [ "$hash1" == "$hash2" ]; then
    echo "Файлы идентичны."
else
    echo "Файлы различаются."
fi

#!/bin/bash
source /home/user/.local/bin/colors.mb4_.sh

THRESHOLD=80 # Пороговое значение использования диска в процентах

echo "📊 Использование дискового пространства:"
df -h | awk 'NR==1 || $5+0 > '"$THRESHOLD"' {print}'

echo -e "\n🔍 Проверяем критически заполненные разделы..."
df -h | awk -v threshold="$THRESHOLD" 'NR>1 {gsub("%","",$5); if ($5 >= threshold) print "${red}⚠ Внимание:${normal} " $6 " заполнен на " $5 "%"}'

#echo -e "${red}⚠ Внимание:${normal} "

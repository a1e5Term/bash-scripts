#!/bin/bash
#source $HOME/.local/bin/colors.mb4.sh

GREEN='\033[32m'	#	${GREEN}		# зелёный цвет знаков
BGRED='\033[41m'	# Красный фон
NORMAL='\033[0m'	# Сброс цвета

THRESHOLD=80 # Пороговое значение использования диска в процентах

echo -e "${GREEN}Все диски:${NORMAL}"
	#-e: позволяет интерпретировать escape-последовательности.
df -h | grep '^/dev/sd' | awk '{print $1, $2, $3, $4, $5, $6}'

echo -e "\n📊 ${GREEN}Использование дискового пространства:${NORMAL}"
df -h | awk 'NR==1 || ($1 ~ /^\/dev\/sd/ && $5+0 > '"$THRESHOLD"') {print}'

echo -e "\n🔍 ${GREEN}Проверяем критически заполненные разделы...${NORMAL}"
df -h | awk -v threshold="$THRESHOLD" -v bgred="$BGRED" -v normal="$NORMAL" 'NR>1 {gsub("%","",$5); if ($5 >= threshold) print bgred "⚠ Внимание:" normal " " $1 " (" $6 ") заполнен на " $5 "%"}'

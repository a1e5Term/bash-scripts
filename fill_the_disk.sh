#!/bin/bash

#продолжить после прерывания
#им н . пр н н

#построить график?
#сохранить время?


DEVICE="/dev/sda1"
#свободное место в байтах на устройстве
FREE_SPACE=$(df --block-size=1 --output=avail ${DEVICE} | tail -n 1)
TARGET_PATH="/media/user/515760b5-4602-493a-bd90-6df6c55d5e3f"

SCRIPT_NAME=$(basename "$0")			# имя без расширения
PATH_FILE_NAME="${SCRIPT_NAME%.*}"  	# полный путь с именем но без расширения

CURRENT="$PATH_FILE_NAME"_"$(date +"%Y-%m-%d_%H-%M")"
echo $CURRENT

#read a

FILE="${TARGET_PATH}/$CURRENT.bin"
dd if=/dev/urandom of="${FILE}" bs=1G count=10 status=progress


#EXTENSION="${FILE##*.}"
#echo "Расширение файла: $EXTENSION"

FILE_SIZE=$(stat --format=%s "${FILE}")

RESULT=$((FREE_SPACE / FILE_SIZE))
echo "Количество копий для записи на диск: $RESULT"
#read a

#создает новый файл с текущ датой 
CURRENT_EXECUTION_TIMES="$TARGET_PATH"/EXECUTION_TIMES_$(date +"%Y-%m-%d_%H-%M").txt
touch $CURRENT_EXECUTION_TIMES

#найти в целевом пути файлы с таким же именем
#"$FILE_NAME.$EXTENSION"

EXECUTION_TIMES=()

for ((i=1; i<=$RESULT; i++)); do
#for ((i=1; i<=5; i++)); do
	echo $i.

	#START_TIME=$(date +%s)  # Запоминаем начальное время
	START_TIME=$(date +%s.%N)  # Получаем время в секундах с наносекундами

	#cp "${FILE}" "${TARGET_PATH}${FILE_NAME}_${i}.pdf"
	rsync --progress "${FILE}" "${TARGET_PATH}${FILE_NAME}_${i}.$EXTENSION"
	#pv "${FILE}" > "${TARGET_PATH}${FILE_NAME}_${i}.pdf"
	
	#END_TIME=$(date +%s)  # Запоминаем конечное время
	END_TIME=$(date +%s.%N)  # Получаем время в секундах с наносекундами

	#EXECUTION_TIME=$((END_TIME - START_TIME))  # Вычисляем время выполнения
	EXECUTION_TIME=$(echo "$END_TIME - $START_TIME" | bc)
	FORMATTED_EXECUTION_TIME=$(printf "%.4f" "$EXECUTION_TIME")

	# Добавляем время выполнения в массив по индексу i
    EXECUTION_TIMES[i]=$FORMATTED_EXECUTION_TIME
	#read a
    echo "${EXECUTION_TIMES[i]}" >> "$CURRENT_EXECUTION_TIMES"
    
done


# Выводим время выполнения для каждой операции по индексу
for ((i=1; i<=$RESULT; i++)); do
#for ((i=1; i<=5; i++)); do
    echo "Время выполнения для операции $i: ${EXECUTION_TIMES[i]} секунд"
done


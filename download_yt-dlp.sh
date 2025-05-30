#!/bin/bash

PATHSAVE="$HOME/.local/bin/yt-dlp"
URL=https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp

instll(){
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "install $1"
		su -c "apt install \"$1\" -y" -
			#Мы используем двойные кавычки вокруг всей команды, чтобы оболочка могла интерпретировать переменную $SOFT.
			#Внутри двойных кавычек мы экранируем переменную $SOFT с помощью обратной косой черты (\), чтобы избежать ее интерпретации до передачи команды в su.
	fi    
}

#SOFT="curl"
#SOFT="ffmpeg"
instll "curl" && instll "ffmpeg" && curl -L $URL -o $PATHSAVE && chmod a+rx $PATHSAVE


#sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
#su -c "curl -L \"$URL\" -o \"$PATHSAVE\"" -
#su -c "chmod a+rx \"$PATHSAVE\"" -


#не рб
#curl -L $URL -o $PATHSAVE/yt-dlp
#chmod a+rx $PATHSAVE/yt-dlp

#!/bin/bash

PATHSAVE="$HOME/.local/bin/yt-dlp"
#PATHSAVE="/usr/local/bin/youtube-dl"
URL="https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp"

instll(){
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "install $1"
		su -c "apt install \"$1\" -y" -
	fi    
}

instll "curl" && instll "ffmpeg" && curl -L $URL -o $PATHSAVE && chmod a+rx $PATHSAVE




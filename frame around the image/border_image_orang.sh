#! /bin/bash
#для DC - %p
convert "$1" -mattecolor orange -frame 7 "${1%.*}"_orange.png

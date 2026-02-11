#! /bin/bash
#для DC - %p
convert "$1" -mattecolor green -frame 7 "${1%.*}"_green.png

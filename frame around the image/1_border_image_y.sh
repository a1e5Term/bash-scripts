#! /bin/bash
#для DC - %p
convert "$1" -mattecolor yellow -frame 7 "${1%.*}"_y.png

#convert -bordercolor lime -border 10 "$1" "${1%.*}"_y.png

#! /bin/bash
#для DC - %p
convert -bordercolor lime -border 10 "$1" "${1%.*}"_y.png

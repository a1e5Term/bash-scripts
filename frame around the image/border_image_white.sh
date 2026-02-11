#! /bin/bash
#для DC - %p
convert "$1" -mattecolor white -frame 7 "${1%.*}"_white.png

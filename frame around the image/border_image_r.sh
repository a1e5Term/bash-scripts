#! /bin/bash
#для DC - %p
convert "$1" -mattecolor red -frame 7 "${1%.*}"_r.png

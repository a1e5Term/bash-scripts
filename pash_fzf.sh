#!/bin/bash

#https://github.com/dylanaraps/pash

export PATH="$HOME/.local/bin:$PATH"

commands=("pash help"  \
		  "pash add"  \
		  "pash copy" \
		  "pash del"  \
		  "pash list" \
		  "pash show" \
		  "pash tree")
		  
CMD=$(printf "%s\n" "${commands[@]}" | fzf --reverse --no-info)

case $CMD in
    "pash help")
		pash
        ;;
    "pash add")
		echo "Введите имя:"
		read NAME
		eval "$CMD $NAME"
        ;;
    "pash copy")
		CMD_2=$(pash list | fzf --reverse)
		eval $CMD $CMD_2
        ;;
    "pash del")
		CMD_2=$(pash list | fzf --reverse)
		eval $CMD $CMD_2
        ;;
    "pash list")
		eval $CMD
        ;;
    "pash show")
		CMD_2=$(pash list | fzf --reverse)
		eval $CMD $CMD_2
        ;;
    "pash tree")
		eval $CMD
        ;;
    *)
        echo "Неизвестная команда"
        ;;
esac

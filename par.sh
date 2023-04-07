#!/bin/ash

if [ -z "$@" ]
then
        echo "No arguments provided for par..."
        /usr/bin/par2 -h
else
        echo "Running par with arguments \"$@\""
        /usr/bin/par2 $@
fi

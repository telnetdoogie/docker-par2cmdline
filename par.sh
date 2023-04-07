#!/bin/ash

if [ -z $1 ]
then
        echo "No arguments provided for par..."
        /usr/bin/par2 -h
else
        echo "Running par with arguments '$@'"
        /usr/bin/par2 $@
fi

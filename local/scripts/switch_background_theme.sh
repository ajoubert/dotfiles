#!/bin/bash
if [ "$1" == 'light' ]
then
	rm ~/.wallpapers/static
	ln -s ~/.wallpapers/static-light ~/.wallpapers/static
	~/.local/scripts/randomBackground.sh;
elif [ "$1" == 'dark' ]
then
	rm ~/.wallpapers/static
	ln -s ~/.wallpapers/static-dark ~/.wallpapers/static
	~/.local/scripts/randomBackground.sh;
else
    echo "Unknown theme...";
fi



#!/bin/bash
#DIRECTORY="$HOME/.wallpapers/static"
DIRECTORY="$HOME/.local/share/wallpapers/wallpapers"

if [ -d "$DIRECTORY" ] && [[ ! $* == *--rand* ]]; then
    feh --recursive --no-fehbg --randomize --bg-fill $DIRECTORY;
else
    if [ ! -d /tmp/wallpapers ]; then
      mkdir /tmp/wallpapers;
    fi

    if [[ $* == *--clean* ]]; then
      rm /tmp/wallpapers/*;
    fi
    file1=$(mktemp /tmp/wallpapers/wallpaper-XXX.jpg)
    ## file2=$(mktemp /tmp/wallpapers/wallpaper-XXX.jpg)
    curl -L --output $file1 'https://unsplash.it/1920/1080/?random'
    ## curl -L --output $file2 'https://unsplash.it/1920/1080/?random'
    feh --recursive --no-fehbg --randomize --bg-fill /tmp/wallpapers;
fi

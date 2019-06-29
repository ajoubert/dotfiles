#!/bin/zsh
DIRECTORY="~/.wallpapers"

if [ -d "$DIRECTORY" ]; then
    feh --recursive --no-fehbg --randomize --bg-fill ~/.wallpapers;
else
    mkdir /tmp/wallpapers;
    file1=$(mktemp /tmp/wallpapers/wallpaper-XXX.jpg)
    file2=$(mktemp /tmp/wallpapers/wallpaper-XXX.jpg)
    curl -L --output $file1 'https://unsplash.it/1920/1080/?random'
    curl -L --output $file2 'https://unsplash.it/1920/1080/?random'
    feh --recursive --no-fehbg --randomize --bg-fill /tmp/wallpapers;
fi

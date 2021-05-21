#!/bin/bash

COVER="/tmp/album_cover.png"
COVER_SIZE="400"
MUSIC_DIR="/mnt/hdd/data/music/"

rm /tmp/extract.jpg >/dev/null &>/dev/null

#path to current song
file="$MUSIC_DIR/$(mpc --format %file% current)"
album="${file%/*}"
#search for cover image
ffmpeg -i $file -an -vcodec copy /tmp/extract.jpg >/dev/null &>/dev/null

if [ -f "/tmp/extract.jpg" ]; then
  art="/tmp/extract.jpg"
else
  art="$HOME/.config/ncmpcpp/default_cover.png"
fi

#copy and resize image to destination
ffmpeg -loglevel 0 -y -i "$art" -vf "scale=$COVER_SIZE:-1" "$COVER"

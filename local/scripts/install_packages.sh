#!/bin/bash

# File containing the list of packages
FILE="$HOME/.config/pkglist.txt"

# Check if the file exists
if [ -f "$FILE" ]; then
  yay -S --needed $(comm -12 <(yay -Slq | sort) <(sort $HOME/.config/pkglist.txt))
else
  echo "File not found: $FILE"
fi

#!/bin/bash

# File containing the list of packages
FILE="$HOME/.config/pkglist.txt"

# Check if the file exists
if [ -f "$FILE" ]; then
  # If filtering is needed, but it filters groups...
  # yay -S --needed $(comm -12 <(yay -Slq | sort) <(sort $FILE))
  yay -S --needed $(awk '/^[^#]/ {print $1}' $FILE)
else
  echo "File not found: $FILE"
fi

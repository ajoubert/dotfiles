#!/bin/bash

# Function to display usage
usage() {
    echo "Uninstall all packages not explicitely defined in pkglist.txt"
    exit 1
}

if [ -n "$1" ]; then
    usage
fi

# File containing the list of packages
FILE="$HOME/.config/pkglist.txt"

# If file doesn't exist, exit with an error
if [ ! -f "$FILE" ]; then
  echo "Error: pkglist.txt not found."
  exit 1
fi

# Uninstall all unlisted packages
yay -Rsu $(comm -23 <(yay -Qq | sort) <(sort $FILE))

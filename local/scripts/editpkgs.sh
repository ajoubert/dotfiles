#!/bin/bash

# Define the file path
FILE="$HOME/.config/pkglist.txt"

# Check if the file exists, if not, create it
if [ ! -f "$FILE" ]; then
    touch "$FILE"
fi

# Check if $EDITOR is set and executable
if [ -z "$EDITOR" ] || [ ! -x "$(command -v "$EDITOR")" ]; then
    echo "The \$EDITOR environment variable is not set to a valid executable. Please set \$EDITOR to your preferred text editor."
    exit 1
fi

# Open the file
$EDITOR "$FILE"

# Sort the file alphabetically and save the changes
sort "$FILE" -o "$FILE"

echo "Package list edited"

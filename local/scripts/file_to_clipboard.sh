#!/bin/bash

# Check if xclip is available
if ! [ -x "$(command -v xclip)" ]; then
    echo "Error: xclip is not installed."
    exit 1
fi
# Check if a file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    exit 1
fi

# Copy the content of the file to the clipboard
xclip -selection clipboard < "$1"

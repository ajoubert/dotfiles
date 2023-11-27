#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 path_to_image"
    exit 1
fi

# Set the provided image as the background using feh
feh --no-fehbg --bg-scale "$1"

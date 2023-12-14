#!/bin/bash

echo 'test' > /tmp/test
# Take a screenshot of a selected area and save it to the clipboard

# Dependencies: scrot

# Check if scrot is installed, exit with an error if it is not
if ! [ -x "$(command -v scrot)" ]; then
  echo 'Error: scrot is not installed.' >&2
  exit 1
fi

# Check if SCREENSHOT_DIR is defined, else use ~
if [ -z "$SCREENSHOT_DIR" ]; then
  SCREENSHOT_DIR=~
fi

# Take a screenshot of a selected area and save it to $SCREENSHOT_DIR as a png with
# timestamp as name

scrot -s "$SCREENSHOT_DIR/$(date +%Y-%m-%d_%H%M%S).png"

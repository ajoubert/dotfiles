#!/bin/sh
xrandr --output HDMI1 --mode 1920x1080 --primary
xrandr --output eDP1 --auto --left-of HDMI1 

#!/bin/bash

LOGFILE="/tmp/monitorhotpluglogs"
echo "Running monitorhotplug" >> $LOGFILE

# Define your external monitor's name (you can get it from xrandr output)
export EXTERNAL_MONITOR="DP-2.1"
export INTERNAL_MONITOR="DP-4"
# Inform udev of the display and xauthority file location
export DISPLAY=":-0"
export XAUTHORITY="/home/sloth/.local/share/xorg/Xauthority"

# Check if the external monitor is connected
if xrandr | grep "$EXTERNAL_MONITOR connected"; then
    # Switch display to external monitor
    xrandr --output $EXTERNAL_MONITOR --auto --primary --output $INTERNAL_MONITOR --off >> $LOGFILE &>> $LOGFILE
else
    # Switch back to laptop display
    xrandr --output $INTERNAL_MONITOR --auto --primary --output $EXTERNAL_MONITOR --off >> $LOGFILE &>> $LOGFILE
fi

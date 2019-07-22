#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
MONITOR=$(polybar -m|head -1|sed -e 's/:.*$//g') polybar first > /dev/null &>/dev/null &
#MONITOR=$(polybar -m|head -1|sed -e 's/:.*$//g') polybar first &
MONITOR_SECONDARY=$(polybar -m|tail -1|sed -e 's/:.*$//g') polybar second > /dev/null &>/dev/null &
#MONITOR_SECONDARY=$(polybar -m|tail -1|sed -e 's/:.*$//g') polybar second &


echo "Polybar launched..."

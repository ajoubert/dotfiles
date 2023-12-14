#!/bin/sh

# If OBS isn't launched, launch it without displaying anything in the
# terminal
if ! pgrep -x "obs" > /dev/null
then
    nohup obs >/dev/null 2>&1 &
    # Wait a moment for obs to load
    sleep 3
fi

# If OBS is launched, toggle recording
if pgrep -x "obs" > /dev/null
then
    obs-cmd recording toggle
fi


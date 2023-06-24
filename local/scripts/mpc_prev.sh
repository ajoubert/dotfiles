#!/bin/bash
notify-send -t 1000 -a mpd 'Previous' 'Instructing mpc to play the previous song'
mpc prev

#!/bin/bash
notify-send -t 1000 'Previous' 'Instructing mpc to play the previous song' --icon=dialog-information
mpc prev

#!/bin/sh
## Scripts launching all secondary programs when bspwm is done loading
update-backgrounds;
mopidy &
polybar main &
polybar secondary &
redshift &
compton &
dunst &

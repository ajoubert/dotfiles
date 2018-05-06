#!/bin/sh
## Scripts launching all secondary programs when bspwm is done loading
update-backgrounds;
mopidy &
polybar -r main &
#polybar -r secondary &
redshift &
compton &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &
dunst &

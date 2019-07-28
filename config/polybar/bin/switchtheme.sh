#!/bin/bash

if [ "$1" == 'light' ]
then
    rm ~/.config/polybar/config;
    touch ~/.config/polybar/config;
    cat ~/.config/polybar/config.colors >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.theme.light >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.general >> ~/.config/polybar/config;
    ~/.config/polybar/bin/launch.sh;
elif [ "$1" == 'dark' ]
then
    rm ~/.config/polybar/config;
    touch ~/.config/polybar/config;
    cat ~/.config/polybar/config.colors >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.theme.dark >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.general >> ~/.config/polybar/config;
    ~/.config/polybar/bin/launch.sh;
else
    echo "Unknown theme...";
fi


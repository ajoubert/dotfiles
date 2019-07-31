#!/bin/bash

## Yeah, really. For some reason echo -e doesn't preserve the newline......
~/.config/polybar/bin/generate_workspaces.js > /tmp/workspaces;

if [ "$1" == 'light' ]
then
    rm ~/.config/polybar/config;
    touch ~/.config/polybar/config;
    cat ~/.config/polybar/config.colors >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.theme.light >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.general.part.1 >> ~/.config/polybar/config;
    cat /tmp/workspaces >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.general.part.2 >> ~/.config/polybar/config;
    ~/.config/polybar/bin/launch.sh;
elif [ "$1" == 'dark' ]
then
    rm ~/.config/polybar/config;
    touch ~/.config/polybar/config;
    cat ~/.config/polybar/config.colors >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.theme.dark >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.general.part.1 >> ~/.config/polybar/config;
    cat /tmp/workspaces >> ~/.config/polybar/config;
    cat ~/.config/polybar/config.general.part.2 >> ~/.config/polybar/config;
    ~/.config/polybar/bin/launch.sh;
else
    echo "Unknown theme...";
fi

rm /tmp/workspaces;


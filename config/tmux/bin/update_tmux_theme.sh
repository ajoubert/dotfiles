#!/bin/bash

if [ "$1" == 'light' ]
then
    rm ~/.config/tmux/tmux.conf
    touch ~/.config/tmux/tmux.conf;
    cat ~/.config/tmux/tmux.conf.light>> ~/.config/tmux/tmux.conf;
    cat ~/.config/tmux/tmux.conf.general >> ~/.config/tmux/tmux.conf;
    tmux source-file ~/.config/tmux/tmux.conf > /dev/null &> /dev/null;
elif [ "$1" == 'dark' ]
then
    rm ~/.config/tmux/tmux.conf;
    touch ~/.config/tmux/tmux.conf;
    cat ~/.config/tmux/tmux.conf.dark >> ~/.config/tmux/tmux.conf;
    cat ~/.config/tmux/tmux.conf.general >> ~/.config/tmux/tmux.conf;
    tmux source-file ~/.config/tmux/tmux.conf > /dev/null &> /dev/null;
else
    echo "Unknown theme...";
fi

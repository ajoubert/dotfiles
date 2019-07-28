#!/bin/bash

if [ "$1" == 'light' ]
then
    rm ~/.tmux.conf
    touch ~/.tmux.conf;
    cat ~/.tmux/tmux.conf.light>> ~/.tmux.conf;
    cat ~/.tmux/tmux.conf.general >> ~/.tmux.conf;
    tmux source-file ~/.tmux.conf > /dev/null &> /dev/null;
elif [ "$1" == 'dark' ]
then
    rm ~/.tmux.conf;
    touch ~/.tmux.conf;
    cat ~/.tmux/tmux.conf.dark >> ~/.tmux.conf;
    cat ~/.tmux/tmux.conf.general >> ~/.tmux.conf;
    tmux source-file ~/.tmux.conf > /dev/null &> /dev/null;
else
    echo "Unknown theme...";
fi

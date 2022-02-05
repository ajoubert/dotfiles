#!/bin/bash

alacrittydir="$( cd "$(dirname "$0")"; cd .. ; pwd -P )"
if [ "$1" == 'light' ]
then
    rm $alacrittydir/alacritty-theme.yml;
    ln -s $alacrittydir/alacritty-solarized-light.yml $alacrittydir/alacritty-theme.yml;
    #killall -USR1 alacritty;
elif [ "$1" == 'dark' ]
then
    rm $alacrittydir/alacritty-theme.yml;
    ##ln -s $alacrittydir/alacritty-solarized-dark.yml $alacrittydir/alacritty-theme.yml;
    ln -s $alacrittydir/alacritty-dracula.yml $alacrittydir/alacritty-theme.yml;
    #ln -s $alacrittydir/alacritty-nord.yml $alacrittydir/alacritty-theme.yml;
    #killall -USR1 alacritty;
else
    echo "Unknown theme...";
fi

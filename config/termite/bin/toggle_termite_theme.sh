#!/bin/bash

termitedir="$( cd "$(dirname "$0")"; cd .. ; pwd -P )"
if [ "$1" == 'light' ]
then
    rm $termitedir/config_colors;
    ln -s $termitedir/config_colors_light $termitedir/config_colors;
    $termitedir/bin/generate_config_file.sh > /dev/null &> /dev/null;
    killall -USR1 termite;
elif [ "$1" == 'dark' ]
then
    rm $termitedir/config_colors;
    ln -s $termitedir/config_colors_dark $termitedir/config_colors;
    $termitedir/bin/generate_config_file.sh > /dev/null &> /dev/null;
    killall -USR1 termite;
else
    echo "Unknown theme...";
fi

#!/bin/bash
killall xwinwrap > /dev/null 2> /dev/null;
switchValue=$((RANDOM%100))

case $switchValue in
0)
    # video / video 
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 > /dev/null 2> /dev/null;
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 -x 1920 > /dev/null 2> /dev/null;
;;
1[0-4])
    ## Static / video
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 > /dev/null 2> /dev/null;
    $HOME/.local/scripts/randomBackground.sh > /dev/null 2> /dev/null;
;;
1[5-9]) ## video / static
    $HOME/.local/scripts/randomBackground.sh > /dev/null 2> /dev/null;
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 -x 1920 > /dev/null 2> /dev/null;
;;
*)
    ## Static / static 
    $HOME/.local/scripts/randomBackground.sh > /dev/null 2> /dev/null;
;;
esac

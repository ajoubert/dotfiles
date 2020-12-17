#!/bin/bash
killall xwinwrap > /dev/null 2> /dev/null;
switchValue=$((RANDOM%4))
## 1 -> static/static 
## 2 -> static/video
## 3 -> video/static
## 4 -> video/video
case $switchValue in
0)
    ## Static / static 
    $HOME/.local/scripts/randomBackground.sh > /dev/null 2> /dev/null;
;;
1)
    ## Static / video
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 > /dev/null 2> /dev/null;
    $HOME/.local/scripts/randomBackground.sh > /dev/null 2> /dev/null;
;;
2) ## video / static
    $HOME/.local/scripts/randomBackground.sh > /dev/null 2> /dev/null;
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 -x 1920 > /dev/null 2> /dev/null;
;;
3)
    # video / video 
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 > /dev/null 2> /dev/null;
    $HOME/.local/scripts/randomVideo.sh -w 1920 -h 1080 -x 1920 > /dev/null 2> /dev/null;
;;
esac

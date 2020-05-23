#!/bin/bash
## Set default values
OFFSETX=0
OFFSETY=0
## Get options
while getopts w:h:x:y: option
do
    case "${option}"
        in
        w) WIDTH=${OPTARG};;
        h) HEIGHT=${OPTARG};;
        x) OFFSETX=${OPTARG};;
        y) OFFSETY=${OPTARG};;
    esac
done

## Load a random animated image
file=$(find -L ~/.wallpapers | grep -e 'mp4' -e 'webm' -e 'mov' | shuf -n1)
## Display random animated image
xwinwrap -ov -g ${WIDTH}x${HEIGHT}+${OFFSETX}+${OFFSETY} -ni -nf -- mpv -wid WID $file --no-osc --no-osd-bar --loop-file --player-operation-mode=cplayer --no-audio --panscan=1.0 --no-keepaspect --no-input-default-bindings --hwdec&

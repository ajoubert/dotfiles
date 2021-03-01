#!/bin/bash
## Set default values
OFFSETX=0
OFFSETY=0
## Get options
while getopts w:h:x:y:v: option
do
    case "${option}"
        in
        w) WIDTH=${OPTARG};;
        h) HEIGHT=${OPTARG};;
        x) OFFSETX=${OPTARG};;
        y) OFFSETY=${OPTARG};;
        v) VIDEO=${OPTARG};;
    esac
done

## Display animated image
xwinwrap -b -s -fs -st -sp -nf -ov -g ${WIDTH}x${HEIGHT}+${OFFSETX}+${OFFSETY} -- mpv -wid WID --really-quiet --framedrop=vo --no-osc --no-osd-bar --loop-file --player-operation-mode=cplayer --no-audio --panscan=1.0 --no-keepaspect --no-input-default-bindings --hwdec ${VIDEO} &

#!/bin/bash

killall xwinwrap > /dev/null 2> /dev/null;

$HOME/.local/scripts/bgVideo.sh -w 1920 -h 1080 -v $1 > /dev/null 2> /dev/null;

#!/usr/bin/env bash

#-------------------------------#
# Display current cover         #
#-------------------------------#

source "`ueberzug library`"

COVER="/tmp/album_cover.png"
X_PADDING=0
Y_PADDING=3

function add_cover() {
    ImageLayer::add [identifier]="cover" [scaler]="fit_contain" [x]="$X_PADDING" [y]="$Y_PADDING" [width]="49" [height]="23" [path]="$COVER"
}

function remove_cover() {
    ImageLayer::remove [identifier]="cover"
}

function you_wait() {
    while inotifywait -q -q -e close_write "$COVER"; do
        add_cover
    done
}

clear

ImageLayer 0< <(
    add_cover
    you_wait
)


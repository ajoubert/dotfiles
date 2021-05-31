#!/usr/bin/env bash

#-------------------------------#
# Display current cover         #
#-------------------------------#

source "`ueberzug library`"

COVER="/tmp/album_cover.jpg"
X_PADDING=0
Y_PADDING=0
WIDTH=49
HEIGHT=19

function add_cover() {
    IMAGE_WIDTH=$(identify -format "%w" /tmp/album_cover.jpg)> /dev/null
    IMAGE_HEIGHT=$(identify -format "%h" /tmp/album_cover.jpg)> /dev/null
    RATIO_WIDTH=$(echo "scale=4; $WIDTH/$IMAGE_WIDTH" | bc)
    RATIO_HEIGHT=$(echo "scale=4; ($HEIGHT*2)/$IMAGE_HEIGHT" | bc)
    if (( $(bc <<< "$RATIO_WIDTH >= $RATIO_HEIGHT") )); then
        CHOSEN_RATIO=$RATIO_WIDTH;
    else
        CHOSEN_RATIO=$RATIO_HEIGHT;
    fi
    MODIFIED_WIDTH=$(echo "scale=4; $IMAGE_WIDTH * $CHOSEN_RATIO" | bc)
    OFFSET_WIDTH=$(echo "scale=0; ($WIDTH - $MODIFIED_WIDTH) / 2" | bc)

    MODIFIED_HEIGHT=$(echo "scale=4; ($IMAGE_HEIGHT * $CHOSEN_RATIO)" | bc)
    OFFSET_HEIGHT=$(echo "scale=0; ($HEIGHT - $MODIFIED_HEIGHT) / 2" | bc)

    echo "Offset: $OFFSET_WIDTH || $OFFSET_HEIGHT" > /tmp/values.tmp
    ImageLayer::add [identifier]="cover" [scaler]="fit_contain" [x]="$X_PADDING" [y]="$Y_PADDING" [width]="$WIDTH" [height]="$HEIGHT" [path]="$COVER"
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


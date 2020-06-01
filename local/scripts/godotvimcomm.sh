#!/bin/bash

FILE_PATH=${1};
DIR_NAME=$(dirname ${FILE_PATH});

cd ${DIR_NAME};
PROJECT_FOLDER=$(git rev-parse --show-toplevel;);

RELATIVE_PATH=${FILE_PATH#"$PROJECT_FOLDER/"};

## Let's switch to the terminal window
bspc desktop Term -f;

## Now let's try to select the vim window
xdotool key ctrl+x f v i m Return slash v i m Return Return;


## Now we may be in a vim window, or we may not. In case we're not, let' s try this:
xdotool key Escape v Escape;

## Now let's make sure we're in the right folder
echo -n ${PROJECT_FOLDER} | xclip -selection c
xdotool key colon c d space ctrl+shift+v;

## Now let's try to open the right file
echo -n ${RELATIVE_PATH} | xclip -selection c;
xdotool key Return numbersign backslash o ctrl+shift+v;

## Let's give git a moment to think
sleep 0.5;
xdotool key Return;

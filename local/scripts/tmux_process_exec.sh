#!/bin/bash

if [ ! "$TMUX" ];
then
    return 1;
fi

tmux new-window -c "#{pane_current_path}" "$@"

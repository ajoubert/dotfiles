#!/bin/bash

~/.config/alacritty/bin/switchtheme.sh $1 > /dev/null &> /dev/null;
~/.tmux/bin/update_tmux_theme.sh $1 > /dev/null;
~/.local/scripts/switch_background_theme.sh $1 > /dev/null &> /dev/null;

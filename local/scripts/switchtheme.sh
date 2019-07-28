#!/bin/bash

~/.config/termite/bin/toggle_termite_theme.sh $1 >/dev/null &>/dev/null;
~/.tmux/bin/update_tmux_theme.sh $1 > /dev/null;
~/.config/polybar/bin/switchtheme.sh $1 > /dev/null &> /dev/null;
~/.local/scripts/switch_background_theme.sh $1 > /dev/null &> /dev/null;

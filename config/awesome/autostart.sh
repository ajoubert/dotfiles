#! /bin/bash

$HOME/.config/awesome/other/picom/launch.sh --opacity &
$HOME/.local/scripts/backlight -b 0.9 &
killall unclutter &>/dev/null; unclutter -idle 2 &
# killall komorebi; komorebi &
xset r rate 200 60 &
##feh --no-fehbg --bg-scale $HOME/.config/awesome/theme/wall.jpg &
feh --no-fehbg --bg-scale $HOME/.config/awesome/theme/walls/godzilla.jpeg &
espanso start
## pgrep -x cycle_wall > /dev/null || $HOME/.local/bin/cycle_wall 30m &
## pgrep -x polkit-gnome-au > /dev/null || /usr/libexec/polkit-gnome-authentication-agent-1 &
## pgrep -x greenclip > /dev/null || $HOME/.local/bin/greenclip daemon &

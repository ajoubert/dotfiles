#! /bin/bash

$HOME/.config/awesome/other/picom/launch.sh --opacity &
$HOME/.local/scripts/backlight -b 0.9 &
killall unclutter; unclutter -idle 2 &
xset r rate 200 60 &
## feh --no-fehbg --bg-fill $HOME/.config/awesome/themes/wall.jpg &
## pgrep -x cycle_wall > /dev/null || $HOME/.local/bin/cycle_wall 30m &
## pgrep -x polkit-gnome-au > /dev/null || /usr/libexec/polkit-gnome-authentication-agent-1 &
## pgrep -x greenclip > /dev/null || $HOME/.local/bin/greenclip daemon &

{
sleep 0.1; xrandr --output HDMI1 --mode 1920x1080 --primary
sleep 0.1; xrandr --output eDP1 --auto --left-of HDMI1
post-bspwm
} &
xsetroot -cursor_name left_ptr
sxhkd &
exec bspwm

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
#exec startxfce4
xrandr --output HDMI-1 --auto --primary
xrandr --output eDP-1 --auto --right-of HDMI-1
xsetroot -cursor_name left_ptr
sxhkd &
start-pulseaudio-x11 &
mopidy &
exec bspwm

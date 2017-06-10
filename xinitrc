xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
export _JAVA_AWT_WM_NONREPARENTING=1
#exec startxfce4
xrandr --output HDMI-1-1 --auto --primary
xrandr --output eDP-1-1 --auto --left-of HDMI-1-1
xsetroot -cursor_name left_ptr
sxhkd &
#start-pulseaudio-x11 &
mopidy &
exec bspwm

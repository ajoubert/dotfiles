#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


{
sleep 0.2; post-bspwm
} &
#xrandr --setprovideroutputsource modesetting NVIDIA-0 --output HDMI-1-1 --mode 1920x1080 --primary --output eDP-1-1 --auto --left-of HDMI-1-1
#xrandr --setprovideroutputsource modesetting NVIDIA-0 --output HDMI-1-1 --mode 1920x1080 --primary
xrandr --setprovideroutputsource modesetting NVIDIA-0 --output eDP-1-1 --auto --primary
xsetroot -cursor_name left_ptr
sxhkd &
exec bspwm;

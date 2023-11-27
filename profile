export LIBVIRT_DEFAULT_URI="qemu:///system"
export XAUTHORITY="$HOME/.local/share/xorg/Xauthority"
if [ "$TERM" != "screen-256color" ]; then
    setterm -blength 0
fi

# if running bash
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

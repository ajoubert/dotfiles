export LIBVIRT_DEFAULT_URI="qemu:///system"
export XAUTHORITY="$HOME/.local/share/xorg/Xauthority"

# if running bash
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

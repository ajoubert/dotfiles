if [ -z ${SHELL_INIT_CMD+x} ]; then C_CMD="cd; clear;"; else C_CMD="cd; clear; $SHELL_INIT_CMD;"; fi
alias c="$C_CMD"
alias ll='ls -lFArth';
alias '?'=duck
alias '??'=google

function open {
  thunar $1 >/dev/null &>/dev/null &
}

## Allows to use sudo with aliases
alias sudo='sudo '

## Quick directory change
alias dotfiles="cd $HOME/.dotfiles/; clear;"
alias cdtomcat="cd /usr/share/tomcat9/"
alias cdunrealproj="cd $HOME/documents/unreal_engine/unreal_projects;"
alias cdunreal="cd $HOME/documents/unreal_engine/;"
alias cdunrealengine="cd $HOME/documents/unreal_engine/UnrealEngine;"
alias wiki="cd $HOME/.local/share/vimwiki/wiki/; clear;";
alias workspace="cd $HOME/workspace/; clear;";
alias getkey="keepassxc-cli clip $HOME/documents/iprt/keepass.kdbx localPwd"
alias keepassxc="QT_AUTO_SCREEN_SCALE_FACTOR=0 keepassxc"
alias pkgs="$HOME/.local/scripts/editpkgs.sh"
alias fpkgs="$HOME/.local/scripts/editflatpakpkgs.sh"
# Unfortunately, haven't managed to both start and immediatly switch to
# given tmux session in one command...
alias startmusic='~/.config/ncmpcpp/cover_obs.sh; tmux new-session -d -s $$ "tmux source-file ~/.config/ncmpcpp/tsession";'
alias music='tmux switch-client -t music'
alias flatpak='flatpak --user'
alias flatpakroot='flatpak --system'
onlinux &&  alias ls='ls -h --color=auto'
onmac &&  alias ls='ls -G'

if [ -x "$(command -v bat)" ]; then
  alias cat='bat'
fi

if [ ! -x "$(command -v sdkmanager)" ]; then
  alias sdkmanager='echo "sdkmanager not installed. You can install it from https://developer.android.com/studio#command-line-tools-only"'
fi


## Regular typos
alias sl=ls

if type "nvim" > /dev/null; then
  alias vim="nvim"
fi

alias c='cd; clear;'
alias ll='ls -lArth;';
alias '?'=duck
alias '??'=google

function open {
  thunar $1 >/dev/null &>/dev/null &
}

## Quick directory change
alias dotfiles="cd $HOME/.dotfiles/; clear;"
alias cdtomcat="cd /usr/share/tomcat9/"
alias cdunrealproj="cd $HOME/documents/unreal_engine/unreal_projects;"
alias cdunreal="cd $HOME/documents/unreal_engine/;"
alias cdunrealengine="cd $HOME/documents/unreal_engine/UnrealEngine;"
alias wiki="cd $HOME/.vimwiki/wiki/; clear;";
alias workspace="cd $HOME/workspace/; clear;";
alias getkey="keepassxc-cli clip $HOME/sync/keepass.kdbx localPwd"
onlinux &&  alias ls='ls -h --color=auto'
onmac &&  alias ls='ls -G'


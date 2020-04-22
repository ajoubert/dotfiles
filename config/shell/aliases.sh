alias c='cd; clear;'
alias ll='ls -lArth;';
#alias zshconfig="vim $HOME/.zshrc"
#alias ohmyzsh="vim $HOME/.oh-my-zsh"
#alias ssc="sudo systemctl"
alias ducks="du -cks * | sort -rn | head -11"
alias firefox="firefox-developer-edition"

function open {
  dolphin $1 >/dev/null &>/dev/null &
}

## Quick directory change
alias cddotfiles="cd $HOME/.dotfiles/; clear;"
alias cdtomcat="cd /usr/share/tomcat9/"
alias cdunrealproj="cd $HOME/documents/unreal_engine/unreal_projects;"
alias cdunreal="cd $HOME/documents/unreal_engine/;"
alias cdunrealengine="cd $HOME/documents/unreal_engine/UnrealEngine;"
alias getkey="keepassxc-cli clip $HOME/sync/keepass.kdbx localPwd"
if [[ onlinux ]];
then
  alias ls='ls -h --color=auto'
elif [[ onmac ]];
  alias ls='ls -G'
fi

## Quickly lists installed android sdk packages installed
alias sdkmanager_list_installed="sdkmanager --list | sed -e '/Available Packages/q'"

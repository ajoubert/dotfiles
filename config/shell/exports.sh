export WALLPAPER_FOLDER="$HOME/.wallpapers/static/"
export ANIMATED_WALLPAPER_FOLDER="$HOME/.wallpapers/animated/"

# SSH agent config, then provides variables
SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
command -v ssh-agent >/dev/null && eval $(ssh-agent)

# User configuration

export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/share/gem/ruby/2.7.0/bin" ] && export PATH="$PATH:$HOME/.local/share/gem/ruby/2.7.0/bin"

export LYNX_CFG_PATH="$HOME/.config/lynx"
export LYNX_CFG="$LYNX_CFG_PATH/lynx.cfg"
export LYNX_LSS="$LYNX_CFG_PATH/lynx.lss"

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  # same for now
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

if [[ -f "$HOME/.vim/vimrc" ]];
then
  export VIM_CONFIG="$HOME/.vim/"
fi
# if [[ -f "$HOME/.config/vim/vimrc" ]];
# then
  # export VIMINIT="source $HOME/.config/vim/vimrc"
# fi

# npm - node
export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules"
export PATH="$NPM_PACKAGES/bin:$PATH"
## unsetting manpath to inherit from it via the manpath command
unset MANPATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# java stuff
## Older version might be used for compatibility of some adb tools...
[ -d "/opt/android-sdk/tools/bin" ] && export PATH="$PATH:/opt/android-sdk/tools/bin"
[ -d "/opt/android-sdk/cmdline-tools/latest/bin" ] && export PATH="$PATH:/opt/android-sdk/cmdline-tools/latest/bin"
export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$JAVA_HOME/bin:$PATH"
export SDKMANAGER_OPTS=""
export ANDROID_SDK_ROOT="/opt/android-sdk"
export ANDROID_SDK="/opt/android-sdk"
export ANDROID_HOME="/opt/android-sdk"
export _JAVA_AWT_WM_NONREPARENTING=1

## Ansible stuff
export PLAYBOOKS_HOME="$HOME/.ansible/inventory/playbooks"

## To enable when working on unity, and disable when building unreal engine
#vscode stuff
export MSBuildSDKsPath=$( echo /usr/share/dotnet/sdk/6.*/Sdks );
export PATH=$MSBuildSDKsPath:$PATH

## Go stuff
export GOPATH=$HOME/.local/go
[ -d "$HOME/.local/go/bin" ] && export PATH="$PATH:$HOME/.local/go/bin"

## Rust / cargo
[ -d "$HOME/.cargo/bin" ] && export PATH="$PATH:$HOME/.cargo/bin"

## Emacs
[ -d "$HOME/.emacs.d/bin" ] && export PATH="$PATH:$HOME/.emacs.d/bin"

# Libvirt stuff, make sure to add your user to the libvirt group
export LIBVIRT_DEFAULT_URI="qemu:///system"

# User dirs stuff
export XDG_VIDEOS_DIR="$HOME/videos"
export XDG_MUSIC_DIR="$HOME/music"

## Kubectl-kubecolor config
# Backup original "kubectl" command path. Supports subsequent imports of the file.
# export KUBECTL_ORIG_PATH="${KUBECTL_ORIG_PATH:-"$(which kubectl)"}"
# Alias the real "kubectl" as "kubectll"
# alias kubectll="${KUBECTL_ORIG_PATH}"
# Alias kubectl to use colors by default
# alias kubectl="kubecolor"
# Enable the autocompletion for the alias too (see auto-complete install above)
# complete -o default -F __start_kubectl kubecolor

## Disabled for now, not really useful...
# be sure not to remove ./ or stuff gets weird
#export CDPATH=\
#./:\
#$HOME


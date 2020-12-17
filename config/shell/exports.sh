export WALLPAPER_FOLDER="$HOME/.wallpapers/static/"
export ANIMATED_WALLPAPER_FOLDER="$HOME/.wallpapers/animated/"

# User configuration

export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export LYNX_CFG_PATH="$HOME/.config/lynx"
export LYNX_CFG="$LYNX_CFG_PATH/lynx.cfg"
export LYNX_LSS="$LYNX_CFG_PATH/lynx.lss"

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  # same for now
  export EDITOR='vim'
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
export ANDROID_HOME="/opt/android-sdk"
export _JAVA_AWT_WM_NONREPARENTING=1

## Ansible stuff
export PLAYBOOKS_HOME="$HOME/workspace/dev_ops/ansible/playbooks"

#vscode stuff
export MSBuildSDKsPath=$( echo /usr/share/dotnet/sdk/3.*/Sdks );
export PATH=$MSBuildSDKsPath:$PATH

## Go stuff
export GOPATH=$HOME/.local/go

## Rust / cargo
[ -d "$HOME/.cargo/bin" ] && export PATH="$PATH:$HOME/.cargo/bin"

## Disabled for now, not really useful...
# be sure not to remove ./ or stuff gets weird
#export CDPATH=\
#./:\
#$HOME


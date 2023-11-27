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
[ -d "$HOME/.nix-profile/bin" ] && export PATH="$PATH:$HOME/.nix-profile/bin"
[ -d "/opt/flutter/bin" ] && export PATH="$PATH:/opt/flutter/bin"

# GTK config
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"

export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons

export LYNX_CFG_PATH="$HOME/.config/lynx"
export LYNX_CFG="$LYNX_CFG_PATH/lynx.cfg"
export LYNX_LSS="$LYNX_CFG_PATH/lynx.lss"

export LANG=en_US.UTF-8

# Tmux
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.config/tmux/plugins"

export GNUPGHOME="$HOME/.local/share/gnupg"

# Bash history
export HISTSIZE=500
export HISTFILESIZE=500
export HISTFILE=/tmp/.hist
export HISTTIMEFORMAT='%F %T '

# Nvidia driver path
export __GL_SHADER_DISK_CACHE_PATH="$HOME/.cache/nv"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  # same for now
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

if [[ -f "$HOME/.config/vim-shared/vimrc" ]];
then
  export VIM_CONFIG="$HOME/.config/vim-shared/"
fi

export XAUTHORITY="$HOME/.local/share/xorg/Xauthority"

# Pass
export PASSWORD_STORE_DIR="$HOME/.local/share/pass/"

# npm - node
# Those are now handled via nvm, use `nvm use 18` for instance
## export NPM_PACKAGES="$HOME/.local/share/npm-global"
## export NPM_CONFIG_PREFIX="$NPM_PACKAGES"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"
## export NODE_PATH="$NPM_PACKAGES/lib/node_modules"
## export PATH="$NPM_PACKAGES/bin:$PATH"
## export NPM_CONFIG_DEVDIR="$HOME/.local/share/node-gyp"
## unsetting manpath to inherit from it via the manpath command
export NVM_DIR="$HOME/.local/share/nvm"
if [ -r /usr/share/nvm/init-nvm.sh ]; then
  source /usr/share/nvm/init-nvm.sh
fi

unset MANPATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# java stuff
## Older version might be used for compatibility of some adb tools...
[ -d "/opt/android-sdk/tools/bin" ] && export PATH="$PATH:/opt/android-sdk/tools/bin"
[ -d "/opt/android-sdk/cmdline-tools/latest/bin" ] && export PATH="$PATH:/opt/android-sdk/cmdline-tools/latest/bin"
export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$JAVA_HOME/bin:$PATH"
export SDKMANAGER_OPTS=""
export ANDROID_SDK_HOME="$HOME/.local/share/android"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export ANDROID_SDK="/opt/android-sdk"
export ANDROID_HOME="/opt/android-sdk"
export _JAVA_AWT_WM_NONREPARENTING=1

## Prevents ~/.nv/ComputeCache by disabling JIT caching
export CUDA_CACHE_DISABLE=1

## AWS
export AWS_CONFIG_FILE="$HOME/.config/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$HOME/.config/aws/credentials"

## Ansible stuff
export ANSIBLE_CONFIG="$HOME/.config/ansible/ansible.cfg"
export ANSIBLE_DATA="$HOME/.ansible"
export ANSIBLE_BECOME_PLUGINS="$ANSIBLE_DATA/plugins/become:/usr/share/ansible/plugins/become"
export ANSIBLE_COLLECTIONS_PATH="$ANSIBLE_DATA/collections:/usr/share/ansible/collections"
export ANSIBLE_ACTION_PLUGINS="$ANSIBLE_DATA/plugins/action:/usr/share/ansible/plugins/action"
export ANSIBLE_CACHE_PLUGINS="$ANSIBLE_DATA/plugins/cache:/usr/share/ansible/plugins/cache"
export ANSIBLE_CALLBACK_PLUGINS="$ANSIBLE_DATA/plugins/callback:/usr/share/ansible/plugins/callback"
export ANSIBLE_CLICONF_PLUGINS="$ANSIBLE_DATA/plugins/cliconf:/usr/share/ansible/plugins/cliconf"
export ANSIBLE_CONNECTION_PLUGINS="$ANSIBLE_DATA/plugins/connection:/usr/share/ansible/plugins/connection"
export ANSIBLE_FILTER_PLUGINS="$ANSIBLE_DATA/plugins/filter:/usr/share/ansible/plugins/filter"
export ANSIBLE_HTTPAPI_PLUGINS="$ANSIBLE_DATA/plugins/httpapi:/usr/share/ansible/plugins/httpapi"
export ANSIBLE_INVENTORY_PLUGINS="$ANSIBLE_DATA/plugins/inventory:/usr/share/ansible/plugins/inventory"
export ANSIBLE_LOCAL_TEMP="$ANSIBLE_DATA/tmp"
export ANSIBLE_LOOKUP_PLUGINS="$ANSIBLE_DATA/plugins/lookup:/usr/share/ansible/plugins/lookup"
export ANSIBLE_LIBRARY="$ANSIBLE_DATA/plugins/modules:/usr/share/ansible/plugins/modules"
export ANSIBLE_MODULE_UTILS="$ANSIBLE_DATA/plugins/module_utils:/usr/share/ansible/plugins/module_utils"
export ANSIBLE_NETCONF_PLUGINS="$ANSIBLE_DATA/plugins/netconf:/usr/share/ansible/plugins/netconf"
export ANSIBLE_ROLES_PATH="$ANSIBLE_DATA/roles:/usr/share/ansible/roles"
export ANSIBLE_STRATEGY_PLUGINS="$ANSIBLE_DATA/plugins/strategy:/usr/share/ansible/plugins/strategy"
export ANSIBLE_TERMINAL_PLUGINS="$ANSIBLE_DATA/plugins/terminal:/usr/share/ansible/plugins/terminal"
export ANSIBLE_TEST_PLUGINS="$ANSIBLE_DATA/plugins/test:/usr/share/ansible/plugins/test"
export ANSIBLE_VARS_PLUGINS="$ANSIBLE_DATA/plugins/vars:/usr/share/ansible/plugins/vars"
export ANSIBLE_DOC_FRAGMENT_PLUGINS="$ANSIBLE_DATA/plugins/doc_fragments:/usr/share/ansible/plugins/doc_fragments"
export ANSIBLE_GALAXY_CACHE_DIR="$ANSIBLE_DATA/galaxy_cache"
export ANSIBLE_GALAXY_TOKEN_PATH="$ANSIBLE_DATA/galaxy_token"
export ANSIBLE_PERSISTENT_CONTROL_PATH_DIR="$ANSIBLE_DATA/pc"
export PLAYBOOKS_HOME="$HOME/.ansible/inventory/playbooks"

## To enable when working on unity, and disable when building unreal engine
#vscode stuff
export MSBuildSDKsPath=$( echo /usr/share/dotnet/sdk/6.*/Sdks );
export PATH=$MSBuildSDKsPath:$PATH

## Go stuff
export GOPATH=$HOME/.local/go
[ -d "$HOME/.local/go/bin" ] && export PATH="$PATH:$HOME/.local/go/bin"

## Rust / cargo
export CARGO_HOME="$HOME/.local/share/cargo"
[ -d "$HOME/.local/share/cargo/bin" ] && export PATH="$PATH:$HOME/.local/share/cargo/bin"

## Emacs
[ -d "$HOME/.emacs.d/bin" ] && export PATH="$PATH:$HOME/.emacs.d/bin"

# Libvirt stuff, make sure to add your user to the libvirt group
export LIBVIRT_DEFAULT_URI="qemu:///system"

# User dirs stuff
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_VIDEOS_DIR="$HOME/videos"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_LOG_HOME="$HOME/.cache"

## Docker
export DOCKER_CONFIG="$HOME/.config/docker"

# GPG for signed git commits 
export GPG_TTY=$(tty)

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


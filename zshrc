alias ll="ls -lArth"
alias c='cd; clear'

alias sc="systemctl"
alias ssc="sudo systemctl"
alias apvlv="apvlv -c /home/alex/.config/apvlv/apvlvrc"

alias sautoremove="sudo pacman -Rnscu  $(pacman -Qdtq)"

alias v+="amixer set Master playback 5%+"
alias v-="amixer set Master playback 5%-"


alias mnthdd="sudo mount /dev/sda2 /mnt/HDD/"
alias mntwindows="sudo mount /dev/sda1 /mnt/windows/"
alias untar="tar -xzvf"
alias mux="tmux new-session -A -s main"
alias weather="curl -4 http://wttr.in/Amsterdam"

cpstat () {
  tar c "$1" | pv | tar x -C "$2"
}

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/scripts"
export LANG=en_US.UTF-8
export VIMINIT="source /home/alex/.config/vim/vimrc"
#PS1="%B%F{red}%(?..%? )%f%b%B%F{black}%n%f%b@%m %B%40<..<%~%<< %b%# "
ZSH_THEME="abaykan"

## NODE NPM stuff
export PATH="$PATH:/opt/node_modules/bin"
export MANPATH="$MANPATH:/opt/nodes_modules/share/man"
export TERM=screen-256color



 UE_HOME=/opt/unreal-engine

   function unrealbuild {
            CURR_DIR=`pwd`;
            PROJ_NAME=$(basename ${1%.uproject});
            $UE_HOME/Engine/Build/BatchFiles/Linux/Build.sh $PROJ_NAME Linux Development -editorrecompile "${CURR_DIR}/${PROJ_NAME}.uproject" -progress -editor -game -NoHotReloadFromIDE
   }

   function unrealeditor {
       DIR="$( cd "$( dirname "$i" )" && pwd )"
       $UE_HOME/Engine/Binaries/Linux/UE4Editor $DIR/$1
   }

   function unrealeditor-debug {
       DIR="$( cd "$( dirname "$i" )" && pwd )"
       $UE_HOME/Engine/Binaries/Linux/UE4Editor-Linux-Debug $DIR/$1
   }

   function unrealgen {
       DIR="$( cd "$( dirname "$i" )" && pwd )"
       pushd $UE_HOME
       ./GenerateProjectFiles.sh -project="$DIR/$1" -game -engine -editor
       popd
   }

   # For automation tests, if used
   function unrealtest {
       DIR="$( cd "$( dirname "$i" )" && pwd )"
           $UE_HOME/Engine/Binaries/Linux/UE4Editor $DIR/$1 -Game -ExecCmds="Automation RunTests $2" -log
   }



source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

clear;

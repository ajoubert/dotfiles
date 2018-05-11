alias ll="ls -lArth"

alias sc="systemctl"
alias ssc="sudo systemctl"
alias apvlv="apvlv -c /home/alex/.config/apvlv/apvlvrc"

alias sautoremove="sudo pacman -Rnscu  $(pacman -Qdtq)"
alias backup_home="rsync -a --delete /home /mnt/usb/HOME_BACKUP"
alias backup_pictures="rsync -a --delete /mnt/hddshared/pictures /mnt/usb/PICTURES_BACKUP"
alias backup_documents="rsync -a --delete /mnt/hddshared/documents /mnt/usb/DOCUMENTS_BACKUP"
alias backup_videos="rsync -a --delete /mnt/hddshared/videos /mnt/usb/VIDEOS_BACKUP"
alias backup_all="backup_home; backup_pictures; backup_documents; backup_videos;"

alias v+="amixer set Master playback 5%+"
alias v-="amixer set Master playback 5%-"

alias c='cd; clear'

alias mnthdd="sudo mount /dev/sda2 /mnt/HDD/"
alias mntwindows="sudo mount /dev/sda1 /mnt/windows/"
alias untar="tar -xzvf"
alias mux="tmux new-session -A -s main"
alias weather="curl -4 http://wttr.in/Amsterdam"


alias nm-state='nmcli device'
alias nm-interfaces='nmcli device show'
alias listwifi='nmcli --pretty --fields SIGNAL,BARS,SSID,RATE,SECURITY,ACTIVE device wifi list | (IFS=''; (for i in {1..5}; do read -r; printf "%s\n" "$REPLY"; done;) && cat | sort -g -k 1r) | head -n 15'
alias nm-wifi-list-all='nmcli --pretty --fields SSID,RATE,BARS,SIGNAL,SECURITY,ACTIVE device wifi list'
alias stopWifi="nmcli radio wifi off"
alias startWifi="nmcli radio wifi on"

nm-wifi-create() {
    if [[ -z "$2" ]]; then
        echo -e "ERROR: argument is missing. Usage: nm-wifi-create #name #filePassword" 1>&2; return 1;
    fi

    if [[ -z "$(nmcli device wifi list | grep -w $1)" ]]; then
        echo "ERROR: the provided SSID is incorrect" 1>&2; return 1;
    fi

    if [[ ! -f "$2" ]]; then
        echo -e "ERROR: the specified file does not exist" 1>&2; return 1;
    fi

    nmcli device wifi connect "$1" password "$( < $2)"
}

cpstat () {
  tar c "$1" | pv | tar x -C "$2"
}

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/scripts"
export LANG=en_US.UTF-8
export WINEPREFIX="/mnt/HDD/WinePrefixes/alex/"
export VIMINIT="source /home/alex/.config/vim/vimrc"

## GEM stuff
export PATH="$PATH:/home/alex/.gem/ruby/2.4.0/bin"

## NODE NPM stuff
export PATH="$PATH:/opt/node_modules/bin"
export MANPATH="$MANPATH:/opt/nodes_modules/share/man"
export TERM=screen-256color

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

clear;

# Detection of interactivity. Shell *must* be 
# interactive or *none* of this applies.

case $- in
  *i*) ;;
  *) return 
esac

# Vi controls when editing a command, just press Esc
set -o vi

# SSH detection
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi

# If not over ssh, ignore CTRL+D
[[ "$SSH_CLIENT" == "remote/ssh" ]] || set -o ignoreeof

# Detection of major operating systems. 

[ -z "$OS" ] && export OS=`uname`
case "$OS" in
  Linux)          export PLATFORM=linux ;;
  *indows*)       export PLATFORM=windows ;;
  FreeBSD|Darwin) export PLATFORM=mac ;;
  *)              export PLATFORM=unknown ;;
esac

onmac () {
  [ "$PLATFORM" = mac ] && return 0
  return 1
}

onwin () {
  [ "$PLATFORM" == windows ]  && return 0
  return 1
}

onlinux () {
  [ "$PLATFORM" == linux ]  && return 0
  return 1
}

onunknown () {
  [ "$PLATFORM" == unknown ]  && return 0
  return 1
}


# Completion
if [ -r /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

force_color_prompt=yes

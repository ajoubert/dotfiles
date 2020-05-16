#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/prompt_modules/prompt_symbol.sh
source $DIR/prompt_modules/git.sh
source $DIR/prompt_modules/kubectl.sh

USE_PREEXEC=false

if [[ -f "$DIR/3rdparty/bash-preexec/bash-preexec.sh" ]];
then
    USE_PREEXEC=true
    source $DIR/3rdparty/bash-preexec/bash-preexec.sh
fi


# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # set all GIT related variables
  # Available vars:
  # GIT_BRANCH (branch name in paranthesis)
  # GIT_REMOTE (status of current branch against remote)
  # GIT_COLOR (status-dependant color)
  # GIT_COMPENSATION (column-offset to align git stats on the right-end side)
  set_git;

  # set all KUBECTL related variables
  # Available vars:
  # PROMPT_KUBECTL (prompt displaying current context)
  # COMPENSATION_KUBECTL (column-offset to align the right-end side)
  set_kubectl;

  TOTAL_COMPENSATION=$((${GIT_COMPENSATION}+${COMPENSATION_KUBECTL}))

  # Set the bash prompt variable.
  PS1=$(printf "\n%*s\r%s\n$PROMPT_SYMBOL " "$(($(tput cols)+${TOTAL_COMPENSATION}))" "$(prompt_right)" "$(prompt_left)")
}

function prompt_right() {
  result=""
  result+="$GIT_STATUS"
  result+="$GIT_BRANCH"
  echo -e $result
}

function prompt_left() {
  #echo -e "\[${COLOR_ACCENT}\]\w\[${COLOR_NONE}\]"
  echo -e "\[${COLOR_ACCENT}\]\w\[${COLOR_NONE}\] ${PROMPT_KUBECTL}"
}

function enable_tty() {
  stty echo;
}

function disable_tty() {
  stty -echo;
}

if [ $USE_PREEXEC = "true" ];
then
  #preexec_functions+=(disable_tty)
  unset precmd_functions
  precmd_functions=[]
  precmd_functions+=(disable_tty)
  precmd_functions+=(set_bash_prompt)
  precmd_functions+=(enable_tty)
else
  # Tell bash to execute this function just before displaying its prompt.
  PROMPT_COMMAND=set_bash_prompt
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/prompt_modules/prompt_symbol.sh
source $DIR/prompt_modules/git.sh
source $DIR/prompt_modules/kubectl.sh

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

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
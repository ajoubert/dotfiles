DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/prompt_modules/prompt_symbol.sh
source $DIR/prompt_modules/git.sh

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
  set_git

  # Set the bash prompt variable.
  PS1=$(printf "\n%*s\r%s\n$PROMPT_SYMBOL " "$(($(tput cols)+${GIT_COMPENSATION}))" "$(prompt_right)" "$(prompt_left)")
}

function prompt_right() {
  result=""
  result+="$GIT_STATUS"
  result+="$GIT_BRANCH"
  echo -e $result
}

function prompt_left() {
  #echo -e "\033[0;35m\w\033[0m"
  echo -e "${COLOR_ACCENT}\w${COLOR_NONE}"
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt

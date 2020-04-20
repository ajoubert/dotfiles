function reset_git_variables() {
  USED_COLORS=""
  GIT_BRANCH=""
  GIT_COLOR=""
  GIT_REMOTE=""
  GIT_COMPENSATION=0
}

function set_git() {

  reset_git_variables;

  local git_status="$(git status 2> /dev/null)"

  ## No need continuing if we're not in a git repo
  [[ $git_status = "" ]] && return 0;

  set_git_color "${git_status}";

  set_git_branch "${git_status}";

  set_git_remote "${git_status}";
  
  set_git_column_compensation;

}

function set_git_column_compensation() {
  local trimmed_used_colors=${USED_COLORS//\\033/b}
  GIT_COMPENSATION=${#trimmed_used_colors}
}

function set_git_remote() {
  remote_pattern="Your branch is (.*) of"

  # Icons count for more columns than how they are displayed, messing up the alignment
  local icon_padding_compensation="aa"
  GIT_REMOTE=""
  if [[ $1 =~ ${remote_pattern} ]]; then
    GIT_REMOTE="\[$COLOR_WHITE\]"
    USED_COLORS+="${GIT_REMOTE}${icon_padding_compensation}"
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      GIT_REMOTE+="↑ "
    else
      GIT_REMOTE+="↓ "
    fi
  else
    GIT_REMOTE=""
  fi
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ $1 =~ ${diverge_pattern} ]]; then
    GIT_REMOTE="\[$COLOR_WHITE\]"
    USED_COLORS+="${GIT_REMOTE}${icon_padding_compensation}"
    GIT_REMOTE+="↕ "
  fi
}

function set_git_branch() {
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $1 =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    GIT_BRANCH="($branch)"
  elif [[ $1 =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    GIT_BRANCH="($commit)"
  fi
}

function set_git_color() {
  if [[ ! $1 =~ "working tree clean" ]]; then
    GIT_COLOR="\[$COLOR_RED\]"
  elif [[ $1 =~ "Your branch is ahead of" ]]; then
    GIT_COLOR="\[$COLOR_YELLOW\]"
  elif [[ $1 =~ "nothing to commit" ]]; then
    GIT_COLOR="\[$COLOR_GREEN\]"
  else
    GIT_COLOR="\[$COLOR_OCHRE\]"
  fi

  USED_COLORS+=${GIT_COLOR}
}

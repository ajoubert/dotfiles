function reset_git_variables() {
  USED_COLORS=""
  GIT_BRANCH=""
  GIT_COLOR=""
  GIT_REMOTE=""
  GIT_COMPENSATION=0
  GIT_STATUS=""
}

function set_git() {

  reset_git_variables;

  if ! [ -x "$(command -v git)" ]; then
      return
  fi

  if [ "$PROMPT_IGNORE_GIT" == "True" ];
  then
    return
  fi

  local git_status="$(timeout 0.1s bash -c 'git status 2> /dev/null')"

  ## No need continuing if we're not in a git repo
  [[ $git_status = "" ]] && return 0;

  set_git_branch "${git_status}";

  set_git_status;
  
  set_git_column_compensation;

}

function set_git_column_compensation() {
  local trimmed_used_colors=${USED_COLORS//\\033/b}
  trimmed_used_colors=${trimmed_used_colors//\\e/b}
  GIT_COMPENSATION=${#trimmed_used_colors}
}

function set_git_branch() {
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  USED_COLORS+="a"; ## again, icon takes a bit of space, but let's not stick to the end (-1 intentionally)

  if [[ $1 =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    GIT_BRANCH=" $branch"
  elif [[ $1 =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    GIT_BRANCH=" $commit"
  fi

  GIT_BRANCH=${COLOR_BLUE}${GIT_BRANCH}${COLOR_NONE}
  USED_COLORS+="${COLOR_BLUE}${COLOR_NONE}"
}


## Status checks modified from https://github.com/denysdovhan/spaceship-prompt/ (MIT license at the time of writing).
## Thanks a bunch to the team working on it!
function set_git_status() {

  GIT_STATUS="["

  local INDEX=$(command git status --porcelain -b 2> /dev/null)

  # Check for untracked files
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS?"
  fi

  # Check for staged files
  if $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS+"
  elif $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS+"
  elif $(echo "$INDEX" | command grep '^UA' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS+"
  fi

  # Check for modified files
  if $(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS!"
  fi

  # Check for renamed files
  if $(echo "$INDEX" | command grep '^R[ MD] ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS»"
  fi

  # Check for deleted files
  if $(echo "$INDEX" | command grep '^[MARCDU ]D ' &> /dev/null); then
    GIT_STATUS="${GIT_STATUS}X"
  elif $(echo "$INDEX" | command grep '^D[ UM] ' &> /dev/null); then
    GIT_STATUS="${GIT_STATUS}X"
  fi

  # Check for stashes
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    GIT_STATUS="${GIT_STATUS}$"
  fi

  # Check for unmerged files
  if $(echo "$INDEX" | command grep '^U[UDA] ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS="
  elif $(echo "$INDEX" | command grep '^AA ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS="
  elif $(echo "$INDEX" | command grep '^DD ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS="
  elif $(echo "$INDEX" | command grep '^[DA]U ' &> /dev/null); then
    GIT_STATUS="$GIT_STATUS="
  fi

  # Check whether branch is ahead
  local is_ahead=false
  if $(echo "$INDEX" | command grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    is_ahead=true
  fi

  # Check whether branch is behind
  local is_behind=false
  if $(echo "$INDEX" | command grep '^## [^ ]\+ .*behind' &> /dev/null); then
    is_behind=true
  fi

  # Check wheather branch has diverged
  if [[ "$is_ahead" == true && "$is_behind" == true ]]; then
    GIT_STATUS="$GIT_STATUS↕"
    USED_COLORS+="aa"
  else
    if [[ "$is_ahead" == true ]];
    then
      GIT_STATUS="$GIT_STATUS↑"
      USED_COLORS+="aa"
    fi

    if [[ "$is_behind" == true ]];
    then
     GIT_STATUS="$GIT_STATUS↓"
     USED_COLORS+="aa"
    fi

  fi

  GIT_STATUS="$GIT_STATUS] "

  if [[ "$GIT_STATUS" = "[] " ]];
  then
    GIT_STATUS=""
  else
    GIT_STATUS=${COLOR_RED}${GIT_STATUS}${COLOR_NONE}
    USED_COLORS+=${COLOR_RED}${COLOR_NONE}
  fi
}

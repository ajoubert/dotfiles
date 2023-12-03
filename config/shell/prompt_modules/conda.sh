
#CONDA_SYMBOL="🅒 "
CONDA_SYMBOL="󱔎 "
CONDA_COLOR="blue"
CONDA_VERBOSE="true"

function reset_conda_variable() {
  PROMPT_CONDA=""
  COMPENSATION_CONDA=0
}

function set_conda() {
  reset_conda_variable;

  [[ $PROMPT_CONDA_SHOW == false ]] && return

  if ! [ -x "$(type -P conda)" ];
  then
      return
  fi

  set_conda_context;

  if [ -z ${CONDA_CONTEXT} ];
  then
    return
  fi

  PROMPT_CONDA=" at \[${COLOR_BLUE}\]${CONDA_CONTEXT} ${CONDA_SYMBOL}\[${COLOR_NONE}\]"
}

function set_conda_context() {

  CONDA_CONTEXT=""

  local conda_env=${CONDA_DEFAULT_ENV}

  if [[ $CONDA_VERBOSE == false ]]; then
    conda_env=${CONDA_DEFAULT_ENV:t}
  fi

  [[ -z $conda_env ]] && return

  CONDA_CONTEXT=$conda_env
}

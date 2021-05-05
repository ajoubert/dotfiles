function reset_dockercontext_variable() {
  PROMPT_DOCKERCONTEXT=""
  COMPENSATION_DOCKERCONTEXT=0
}

#DOCKERCONTEXT_SYMBOL=" "
DOCKERCONTEXT_SYBOL=" 🐳"

function set_dockercontext() {
	reset_dockercontext_variable;

  if ! [ -x "$(command -v docker)" ];
  then
      return
  fi

  set_dockercontext_context;

  if [ -z ${DOCKERCONTEXT_CONTEXT} ];
  then
    return
  fi

	PROMPT_DOCKERCONTEXT=" on \[${LIGHT_CYAN}\]${DOCKERCONTEXT_CONTEXT}${DOCKERCONTEXT_SYMBOL}\[${COLOR_WHITE}\]"
}

function set_dockercontext_context() {
	DOCKERCONTEXT_CONTEXT=""

  local docker_remote_context

  # Docker has three different ways to work on remote Docker hosts:
  #  1. docker-machine
  #  2. DOCKER_HOST environment variable
  #  3. docker context (since Docker 19.03)
  if [[ -n $DOCKER_MACHINE_NAME ]]; then
    docker_remote_context="$DOCKER_MACHINE_NAME"
  elif [[ -n $DOCKER_HOST ]]; then
    # Remove protocol (tcp://) and port number from displayed Docker host
    docker_remote_context="$(basename $DOCKER_HOST | cut -d':' -f1)"
  else
    # Docker contexts can be set using either the DOCKER_CONTEXT environment variable
    # or the `docker context use` command. `docker context ls` will show the selected
    # context in both cases. But we are not interested in the local "default" context.
    docker_remote_context=$(docker context ls --format '{{if .Current}}{{if ne .Name "default"}}{{.Name}}{{end}}{{end}}' 2>/dev/null)
    [[ $? -ne 0 ]] && return

    docker_remote_context=$(echo $docker_remote_context | tr -d '\n')
  fi

  [[ -z $docker_remote_context ]] && return

	DOCKERCONTEXT_CONTEXT=$docker_remote_context
}

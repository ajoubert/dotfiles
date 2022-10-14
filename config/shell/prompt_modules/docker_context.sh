function reset_dockercontext_variable() {
  PROMPT_DOCKERCONTEXT=""
  COMPENSATION_DOCKERCONTEXT=0
}

#DOCKERCONTEXT_SYMBOL=" "
DOCKERCONTEXT_SYMBOL=" 🐳"

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

	PROMPT_DOCKERCONTEXT=" on \[${LIGHT_CYAN}\]${DOCKERCONTEXT_CONTEXT}${DOCKERCONTEXT_SYMBOL}\[${COLOR_NONE}\]"
}

function set_dockercontext_context() {

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

    ## Because the check is long, only check it once then check it again once docker context is used
    HISTORY=$(history | tail -2 | head -1 | cut -c8-999)
    if [[ "$DOCKERCONTEXT_CONTEXT" == "" ]] || [[ "$HISTORY" == *"docker context use"* ]];
    then
      DOCKERCONTEXT_CONTEXT=""
      docker_remote_context="$(timeout 0.5s bash -c '~/.local/scripts/docker_get_remote_context.sh')"
      ##docker_remote_context=$(docker context ls --format '{{if .Current}}{{if ne .Name "default"}}{{.Name}}{{end}}{{end}}' 2>/dev/null)
      [[ $? -ne 0 ]] && return
      docker_remote_context=$(echo $docker_remote_context | tr -d '\n')
    fi
  fi

	DOCKERCONTEXT_CONTEXT=$docker_remote_context
}

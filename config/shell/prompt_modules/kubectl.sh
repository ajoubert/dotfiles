function reset_kubectl_variable() {
  PROMPT_KUBECTL=""
  COMPENSATION_KUBECTL=0
}

KUBECTL_SYMBOL=" ☸️"

function set_kubectl() {
	reset_kubectl_variable;

  if ! [ -x "$(command -v kubectl)" ];
  then
      return
  fi

  set_kubectl_context;

  if [ -z ${KUBECTL_CONTEXT} ];
  then
    return
  fi

	PROMPT_KUBECTL=" at \[${COLOR_BLUE}\]${KUBECTL_CONTEXT}${KUBECTL_SYMBOL}\[${COLOR_WHITE}\]"
}

function set_kubectl_context() {
	KUBECTL_CONTEXT=""
	local kube_context=$(kubectl config current-context 2>/dev/null)
	[[ -z $kube_context ]] && return

  if [[ "$kube_context" = "minikube" ]];
  then
    ## If the current context is minikube, only display it when running
    ## Because the check is long, only check it once then check it again once minikube is used
    HISTORY=$(history | tail -2 | head -1 | cut -c8-999)
    if [[ "$MINIKUBE_STATUS" == "" ]] || [[ "$HISTORY" == *"minikube"* ]];
    then
      MINIKUBE_STATUS=$(minikube status 2>/dev/null)
    fi
    [[ $MINIKUBE_STATUS != *"host: Running"* ]] && return
  fi

	local kube_namespace=$(kubectl config view -minify --output 'jsonpath={..namespace}' 2>/dev/null)
	[[ -n $kube_namespace && "$kube_namespace" != "default" ]] && kube_context="$kube_context ($kube_namespace)"

  if [ "${#kube_context}" -gt "25" ];
  then
    kube_context=$(echo $kube_context | cut -c1-25)
    kube_context="${kube_context}..."
  fi

	KUBECTL_CONTEXT=$kube_context
}

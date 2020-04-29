function reset_kubectl_variable() {
  PROMPT_KUBECTL=""
  COMPENSATION_KUBECTL=0
}

KUBECTL_SYMBOL="☸️ "

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

	PROMPT_KUBECTL="at \[${COLOR_BLUE}\]${KUBECTL_SYMBOL}${KUBECTL_CONTEXT}\[${COLOR_WHITE}\]"
}

function set_kubectl_context() {
	KUBECTL_CONTEXT=""
	local kube_context=$(kubectl config current-context 2>/dev/null)
	[[ -z $kube_context ]] && return

	local kube_namespace=$(kubectl config view -minify --output 'jsonpath={..namespace}' 2>/dev/null)
	[[ -n $kube_namespace && "$kube_namespace" != "default" ]] && kube_context="$kube_context ($kube_namespace)"

  if [ "${#kube_context}" -gt "25" ];
  then
    kube_context=$(echo $kube_context | cut -c1-25)
    kube_context="${kube_context}..."
  fi

	KUBECTL_CONTEXT=$kube_context
}
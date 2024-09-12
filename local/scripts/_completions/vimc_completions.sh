_vimc_completion() {
    local cur opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$(compgen -c)  # list of commands in $PATH

    COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
}

complete -F _vimc_completion vimc

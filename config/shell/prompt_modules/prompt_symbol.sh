# Return the prompt symbol to use, colorized based on the return value of the
# previous command.

function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\[${base00}\]➜\[${COLOR_WHITE}\] "
  else
      PROMPT_SYMBOL="\[${COLOR_RED}\]➜\[${COLOR_WHITE}\] "
  fi
}

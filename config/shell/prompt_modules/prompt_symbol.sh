# Return the prompt symbol to use, colorized based on the return value of the
# previous command.

function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      #PROMPT_SYMBOL="\[${base00}\]➜\[${COLOR_NONE}\] "
      ## For some reason, the use of COLOR_NONE breaks the term when moving back in the history...
      PROMPT_SYMBOL="➜ "
  else
      #PROMPT_SYMBOL="\[${COLOR_RED}\]➜\[${COLOR_NONE}\] "
      PROMPT_SYMBOL="\[${COLOR_RED}\]➜\[${COLOR_NONE}\] "
  fi
}

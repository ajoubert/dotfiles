#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

SHELLCONFIG="$HOME/.config/shell"

if [[ -f "$SHELLCONFIG/private.sh" ]];
then
  source $SHELLCONFIG/private.sh
fi

source $SHELLCONFIG/init.sh
source $SHELLCONFIG/colors.sh
source $SHELLCONFIG/exports.sh
source $SHELLCONFIG/aliases.sh

# Auto-source all completion scripts in ~/.local/scripts/_completions/
if [ -d "$HOME/.local/scripts/_completions/" ]; then
  for f in "$HOME/.local/scripts/_completions/"*; do
    [ -r "$f" ] && source "$f"
  done
fi

## IMPORTANT: must be the last config file to load because of preexec
source $SHELLCONFIG/prompt.sh

if [ -z ${SHELL_INIT_CMD+x} ]; then : ; else $SHELL_INIT_CMD; fi

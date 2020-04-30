#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/shell/init.sh
source ~/.config/shell/colors.sh
source ~/.config/shell/exports.sh
source ~/.config/shell/aliases.sh
source ~/.config/shell/prompt.sh

if [[ -f "$HOME/.bash_private" ]];
then
  source ~/.bash_private
fi

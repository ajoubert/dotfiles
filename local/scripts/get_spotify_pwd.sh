#/bin/bash
ENTRY_FILE="$HOME/.local/scripts/private/spotify_pwd_entry"
if [ ! -f "$ENTRY_FILE" ];
then
  echo "Pass entry file is missing, please create it at $ENTRY_FILE"
fi
pass $(cat "$ENTRY_FILE") | head -n 1

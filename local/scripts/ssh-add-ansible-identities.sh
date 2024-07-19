#/bin/bash
# Checks if the global variable KEEPASSXC_DATABASE_PATH is set
if [ -z "$KEEPASSXC_DATABASE_PATH" ]; then
    echo "KEEPASSXC_DATABASE_PATH is not set"
    exit 1
fi

# Checks if password of database is passed as $1
if [ -z "$1" ]; then
  echo -n "Enter KeePassXC database password: "
  read -s KP_PASSWORD
  echo
else
  KP_PASSWORD="$1"
fi

if [ "$2" == "--dry-run" ]; then
  DRY_RUN=true
fi

add_entry() {
    local entry_name="$1"
    local password=$(echo "$KP_PASSWORD" | keepassxc-cli show -s "$KEEPASSXC_DATABASE_PATH" "$entry_name" --quiet --attributes Password)
    if [ -z "$password" ]; then
        echo "Password for $entry_name not found"
        exit 1
    fi
    SSH_ASKPASS=ssh_give_pass.sh ssh-add "$HOME/.ssh/ansible/$1" <<< "$password"
}

loop_entries() {
  local entries=$(echo "$KP_PASSWORD" | keepassxc-cli ls --quiet -R "$KEEPASSXC_DATABASE_PATH" | grep -E "id_ansible_")
  if [ -z "$entries" ]; then
    echo "No entries found, is password correct?"
    exit 1
  fi

  if [ "$DRY_RUN" == "true" ]; then
    echo "Dry-run mode enabled, password valid, exiting"
    return
  fi

  for entry in $entries; do
    add_entry "$entry"
  done
}

loop_entries

unset KP_PASSWORD

#!/bin/bash

if [ -z "$KEEPASSXC_DATABASE_PATH" ]; then
    echo "KEEPASSXC_DATABASE_PATH is not set"
    exit 1
fi

if [ -z "$ANSIBLE_SUDO_PASS_ENTRY" ]; then
    echo "ANSIBLE_SUDO_PASS_ENTRY is not set"
    exit 1
fi

# Check if ssh-add-ansible-identities.sh binary is available on current
# shell
if ! which ssh-add-ansible-identities.sh > /dev/null &>/dev/null; then
    echo "ssh-add-ansible-identities.sh is not available on current shell"
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

# Get identities, exit early if it fails
if ! ssh-add-ansible-identities.sh $KP_PASSWORD; then
    exit 1
fi

SUDOPASS=$(echo "$KP_PASSWORD" | keepassxc-cli show -s "$KEEPASSXC_DATABASE_PATH" "$ANSIBLE_SUDO_PASS_ENTRY" --quiet --attributes Password)

ANSIBLE_SUDO_PASS=$SUDOPASS ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/activate_forwarding.yml

ssh-add -D

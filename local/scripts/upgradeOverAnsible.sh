#!/bin/bash

# Check if ssh-add-ansible-identities.sh binary is available on current
# shell
if ! which ssh-add-ansible-identities.sh > /dev/null &>/dev/null; then
    echo "ssh-add-ansible-identities.sh is not available on current shell"
    exit 1
fi

ssh-add-ansible-identities.sh

ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/activate_forwarding.yml
ansible-playbook $PLAYBOOKS_HOME/upgrade_all.yml
ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/deactivate_forwarding.yml

ssh-add -D

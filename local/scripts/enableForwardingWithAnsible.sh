#!/bin/bash

# Check if the ansible identities script is executable
if [ ! -x "ssh-add-ansible-identities.sh" ]; then
    echo "ssh-add-ansible-identities.sh is not available"
    exit 1
fi

ssh-add-ansible-identities.sh

add_entry "id_ansible_serv-0"

ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/activate_forwarding.yml

ssh-add -D

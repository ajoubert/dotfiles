#!/bin/bash

# Check if the ansible identities script is executable
if [ ! -x "ssh-add-ansible-identities.sh" ]; then
    echo "ssh-add-ansible-identities.sh is not available"
    exit 1
fi

ssh-add-ansible-identities.sh

ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/activate_forwarding.yml
ansible-playbook $PLAYBOOKS_HOME/upgrade_all.yml
ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/deactivate_forwarding.yml

ssh-add -D

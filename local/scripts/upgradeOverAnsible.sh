#!/bin/bash
ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/activate_forwarding.yml
ansible-playbook $PLAYBOOKS_HOME/upgrade_all.yml
ansible-playbook $PLAYBOOKS_HOME/ovh/serv-0/deactivate_forwarding.yml

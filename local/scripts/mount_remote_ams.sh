#!/bin/sh
#ansible-playbook $ANSIBLE_DATA/inventory/playbooks/ovh/serv-0/activate_forwarding.yml;
#sshfs sloth@ams:/media/sloth/storage/a/ /mnt/remotes/ams/ -o allow_other

sshfs sloth@ams-direct-eth:/media/sloth/storage/a/ /mnt/remotes/ams/ -o allow_other

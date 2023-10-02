#!/bin/sh
sudo umount /mnt/remote;

ansible-playbook $ANSIBLE_DATA/inventory/playbooks/ovh/serv-0/deactivate_forwarding.yml;

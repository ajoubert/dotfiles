#!/bin/bash

sudo systemctl start sshd;
sudo systemctl stop wg-quick@cluster;
sudo systemctl stop wg-quick@wg-int;
virsh start win10;

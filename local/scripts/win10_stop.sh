#!/bin/bash

virsh shutdown win10;
sudo systemctl stop sshd;
sudo systemctl start wg-quick@wg-int;
sudo systemctl start wg-quick@cluster;

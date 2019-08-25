#!/bin/bash
if [ -n "$1" ];
then
  IP=$1
else
  echo "No ip provided, attempting default IP: 192.168.2.3"
  IP="192.168.2.3"
fi

sshfs -o rw,nosuid,nodev,identityfile=$HOME/.config/kdeconnect/privateKey.pem,port=1740 kdeconnect@$IP:/ /mnt/phone

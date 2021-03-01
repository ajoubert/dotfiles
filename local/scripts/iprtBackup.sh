#!/bin/bash

## First let's select everything we deem worth backing up
## Then let's open the virtual file system
sudo cryptsetup open $HOME/documents/iprt.img iprt
sudo mount /dev/mapper/iprt /mnt/secret
## Copy the content into the virtual file system
gpg -a --export-filter drop-subkey='expired -t' --export >/mnt/secret/data/mypubkeys.asc
gpg -a --export-filter drop-subkey='expired -t' --export-secret-keys >/mnt/secret/data/myprivatekeys.asc
gpg --export-ownertrust >/mnt/secret/data/otrust.txt
sudo cp ~/documents/iprt/* /mnt/secret/data/
## Close the file system

sudo umount /mnt/secret
sudo cryptsetup close iprt

## Send it over to gdrive
cd ~/workspace/web/gdrive;
node ~/workspace/web/gdrive/index.js -f ~/documents/iprt/iprt.img -n iprt.img -d;

#!/bin/bash

IMG_FILE="$HOME/documents/iprt.img"

## First let's check whether the file exists
if [ -f "$IMG_FILE" ]; then
    echo "Using $IMG_FILE";
else 
    echo "iprt.img not found, pulling to $IMG_FILE"
    cd ~/workspace/gdrive;
    node ~/workspace/gdrive/index.js -f ~/documents/iprt.img -n iprt.img -D -d;
fi

## Now let's open that file
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
cd ~/workspace/gdrive;
node ~/workspace/gdrive/index.js -f ~/documents/iprt.img -n iprt.img -d;

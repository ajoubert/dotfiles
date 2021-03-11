#!/bin/bash

IMG_FILE="$HOME/documents/iprt.img"
GDRIVE_LOCATION="/mnt/hdd/data/workspace_archived/gdrive"

## First let's check whether the file exists
if [ -f "$IMG_FILE" ]; then
    echo "Using $IMG_FILE";
else 
    echo "iprt.img not found, pulling to $IMG_FILE"
    pushd $GDRIVE_LOCATION;
    node $GDRIVE_LOCATION/index.js -f ~/documents/iprt.img -n iprt.img -D -d;
    popd;
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
pushd $GDRIVE_LOCATION;
node $GDRIVE_LOCATION/index.js -f ~/documents/iprt.img -n iprt.img -d;
popd;

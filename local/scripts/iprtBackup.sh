#!/bin/bash

IMG_FILE="/tmp/iprt.img"
GDRIVE_LOCATION="$HOME/.local/scripts/gdrive"

## First let's check whether the file exists
if [ -f "$IMG_FILE" ]; then
    echo "Using $IMG_FILE";
else 
    echo "iprt.img not found, pulling to $IMG_FILE"
    pushd $GDRIVE_LOCATION;
    node $GDRIVE_LOCATION/index.js -f $IMG_FILE -n iprt.img -D -d;
    popd;
fi

if [ -f "$IMG_FILE" ]; then
    echo "Mounting file and updating content";
else
    echo "iprt.img still not found, aborting";
    exit 1;
fi

## Now let's open that file
sudo cryptsetup open $IMG_FILE iprt
sudo mount /dev/mapper/iprt /mnt/secret

echo 'mounted';
ls -l /mnt/secret;

## Copy the content into the virtual file system
gpg -a --export-filter drop-subkey='expired -t' --export >/mnt/secret/data/mypubkeys.asc
gpg -a --export-filter drop-subkey='expired -t' --export-secret-keys >/mnt/secret/data/myprivatekeys.asc
gpg --export-ownertrust >/mnt/secret/data/otrust.txt
sudo cp /mnt/hdd/syncthings/accounting/accounting.gnucash /mnt/secret/data/
sudo cp /mnt/hdd/syncthings/azus-documents/keepass.kdbx /mnt/secret/data/

## Close the file system
sudo umount /mnt/secret
sudo cryptsetup close iprt

## Send it over to gdrive
pushd $GDRIVE_LOCATION;
node $GDRIVE_LOCATION/index.js -f $IMG_FILE -n iprt.img -d;
popd;

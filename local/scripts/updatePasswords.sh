#!/bin/sh

# Start to export the database
FILE=$1
if [ ! -n "$FILE" ]; then
  echo "File name missing..."
  echo "Usage: updatePassword [file]"
  exit 1
fi

if [ ! -f $FILE ]; then
  echo "Keepass file not found..."
  exit 1
fi

echo -n "Keepass database password: "
read -s password
echo

# Extracting passwords in temporary file
echo $password | keepassxc-cli export -f csv -q $FILE > /tmp/keepass.csv
echo "Passwords extracted, initializing database"

LOCALPWD_NOTES=$(echo $password | keepassxc-cli show $FILE localPwd | grep Notes)
LOCALPWD_KEY=${LOCALPWD_NOTES:7:50}

echo -n "Found key to be ${LOCALPWD_KEY}"
echo
read -p "Should we continue with that key? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Okay, let's not do it then";
  rm /tmp/keepass.csv;
  exit 1
fi

pass init "$LOCALPWD_KEY" 
python2 ~/.local/scripts/csv2pass.py -i /tmp/keepass.csv -r keepPass/;
rm /tmp/keepass.csv;

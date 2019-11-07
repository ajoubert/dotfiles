#!/bin/sh

# Start to export the database
FILE=$1
if [ ! -n "$1" ]; then
  echo "File name missing..."
  echo "Usage: updatePassword [file]"
  exit 1
fi

if [ ! -f $1 ]; then
  echo "Keepass file not found..."
  exit 1
fi

echo -n "Keepass database password: "
read -s password
echo

# Extracting passwords in temporary file
echo $password | keepassxc-cli export -f csv -q $1 > /tmp/keepass.csv
echo "Passwords extracted, initializing database"

pass init "$(cat ~/.local/scripts/private/passwords_key)" 
python2 ~/.local/scripts/csv2pass.py -i /tmp/keepass.csv -r keepPass/;
rm /tmp/keepass.csv;

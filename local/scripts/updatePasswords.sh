#!/bin/sh
pass init "$(cat /home/alex/.local/scripts/private/passwords_key)" 
python2 /home/alex/.local/scripts/csv2pass.py -i /tmp/keepass.csv -r keepPass/;
rm /tmp/keepass.csv;

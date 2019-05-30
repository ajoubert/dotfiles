#!/bin/sh
pass init "$(cat ~/.local/scripts/private/passwords_key)" 
python2 ~/.local/scripts/csv2pass.py -i /tmp/keepass.csv -r keepPass/;
rm /tmp/keepass.csv;

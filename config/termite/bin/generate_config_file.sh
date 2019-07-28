#!/bin/bash
termitedir="$( cd "$(dirname "$0")"; cd .. ; pwd -P )"
rm $termitedir/config;
touch $termitedir/config;
cat $termitedir/config_colors >> $termitedir/config;
cat $termitedir/config_general >> $termitedir/config;
cat $termitedir/config;
echo "All done, see output above";

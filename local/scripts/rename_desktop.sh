#/bin/sh
if [ -n "$1" ];
then
  bspc desktop --rename "$1";
fi

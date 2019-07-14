#!/usr/bin/env bash
ALL_MONITORS=$(bspc query -M --names)
CURRENT_MONITOR=$(bspc query -M -m focused --names)

RESULT=1

for mon in $ALL_MONITORS
do
    if [[ "$mon" = "$CURRENT_MONITOR" ]]; then
        echo "^$RESULT";
        exit 0;
    fi
    RESULT=$((RESULT + 1))
done
exit 1;

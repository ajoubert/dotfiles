#!/usr/bin/env sh

# Terminate already running bar instances
killall -9 polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
DISPLAY1="HDMI-0"
#[[ ! -z "$DISPLAY1" ]] && MONITOR="$DISPLAY1" polybar primary &

DISPLAYS="$(xrandr -q | grep ' connected' | grep -v ' $DISPLAY1' | cut -d ' ' -f1)"
for display in $DISPLAYS; do
    if [[ "$display" = "$DISPLAY1" ]];
    then [[ ! -z "$display" ]] && MONITOR_PRIMARY="$display" polybar primary & echo -e "Launching primary on ${display}"
    else
    [[ ! -z "$display" ]] && MONITOR_SECONDARY="$display" polybar secondary & echo -e "Launching secondary on ${display}"
    fi
done;

echo "Bars launched..."

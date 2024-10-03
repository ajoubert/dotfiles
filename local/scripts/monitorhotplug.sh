#!/bin/bash

LOGFILE="/tmp/monitorhotpluglogs"
echo "---------------------------" > $LOGFILE

# Inform udev of the display and xauthority file location
export DISPLAY=":-0"

# Checks if XAUTHROTY is set, if not set it
XAUTHORITY_FILE=$(ls /tmp/xauth_* | head -n 1)

# Check if the laptop lid is closed
LID_STATE=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')
echo "Lid state: $LID_STATE" >> $LOGFILE

# If the XAUTHORITY file is found, export it
if [ -n "$XAUTHORITY_FILE" ]; then
    export XAUTHORITY="$XAUTHORITY_FILE"
    echo "Using XAUTHORITY: $XAUTHORITY" >> $LOGFILE
else
    echo "XAUTHORITY file not found" >> $LOGFILE
    exit 1
fi

CONNECTED_DISPLAYS=($(xrandr | grep " connected" | grep -Eo "^[a-zA-Z0-9\.\-]*"))
DISCONNECTED_DISPLAYS=($(xrandr | grep " disconnected" | grep -Eo "^[a-zA-Z0-9\.\-]*"))

echo "Connected displays: ${CONNECTED_DISPLAYS[@]}" >> $LOGFILE
echo "Disconnected displays: ${DISCONNECTED_DISPLAYS[@]}" >> $LOGFILE

# Turn off all disconnected displays
for EDISPLAY in "${DISCONNECTED_DISPLAYS[@]}"; do
    /usr/bin/xrandr --output "$EDISPLAY" --off
    echo "Turned off disconnected display: $EDISPLAY" >> $LOGFILE
done

# Preset configurations for specific setups
function apply_preset {
  case "$1" in
    "DP-4 DP-2.2 DP-2.3")
      echo "Applying preset for DP-4, DP-2.2, DP-2.3" >> $LOGFILE
      /usr/bin/xrandr --output DP-2.3 --auto --primary
      /usr/bin/xrandr --output DP-2.2 --auto --right-of DP-2.3
      /usr/bin/xrandr --output DP-4 --off
      ;;
    "DP-4 DP-2.2 DP-2.3 DP-2.1")
      echo "Applying preset for DP-4, DP-2.2, DP-2.3, DP-2.1" >> $LOGFILE
      /usr/bin/xrandr --output DP-4 --off
      /usr/bin/xrandr --output DP-2.3 --auto --primary --left-of DP-2.2
      /usr/bin/xrandr --output DP-2.2 --auto
      /usr/bin/xrandr --output DP-2.1 --auto --pos 960x1080 --rotate inverted
      ;;
    *)
      echo "No preset matched, setting everything to auto" >> $LOGFILE
      PREV_DISPLAY=${CONNECTED_DISPLAYS[0]}
      /usr/bin/xrandr --output "$PREV_DISPLAY" --auto --primary
     
      for EDISPLAY in "${CONNECTED_DISPLAYS[@]:1}"; do
          /usr/bin/xrandr --output "$EDISPLAY" --auto --right-of "$PREV_DISPLAY"
          PREV_DISPLAY=$EDISPLAY
      done
      ;;
  esac
}

# Check for specific display combinations and apply the corresponding preset
CONNECTED_DISPLAY_STRING="${CONNECTED_DISPLAYS[@]}"
echo "Connected display as a string:" >> $LOGFILE
echo "$CONNECTED_DISPLAY_STRING" >> $LOGFILE
apply_preset "$CONNECTED_DISPLAY_STRING"

# Log the final xrandr configuration
/usr/bin/xrandr >> $LOGFILE 2>&1

echo "---------------------------" >> $LOGFILE

#!/bin/bash

LOGFILE="/tmp/monitorhotpluglogs"
echo "---------------------------" >> $LOGFILE

# Inform udev of the display and xauthority file location
export DISPLAY=":-0"

# Checks if XAUTHROTY is set, if not set it
XAUTHORITY_FILE=$(ls /tmp/xauth_* | head -n 1)

# If the XAUTHORITY file is found, export it
if [ -n "$XAUTHORITY_FILE" ]; then
    export XAUTHORITY="$XAUTHORITY_FILE"
    echo "Using XAUTHORITY: $XAUTHORITY" >> $LOGFILE
else
    echo "XAUTHORITY file not found" >> $LOGFILE
    exit 1
fi

INTERNAL_DISPLAY=$(xrandr | grep " connected" | grep -Eo "^eDP[0-9\-]*")
EXTERNAL_DISPLAYS=($(xrandr | grep " connected" | grep -E -v "^$INTERNAL_DISPLAY" | grep -Eo "^[a-zA-Z0-9\.\-]*"))
DISCONNECTED_DISPLAYS=($(xrandr | grep " disconnected" | grep -Eo "^[a-zA-Z0-9\.\-]*"))

echo "Internal display: $INTERNAL_DISPLAY" >> $LOGFILE
echo "External displays: ${EXTERNAL_DISPLAYS[@]}" >> $LOGFILE
echo "External displays: ${DISCONNECTED_DISPLAYS[@]}" >> $LOGFILE

# Turn off all disconnected displays
for EDISPLAY in "${DISCONNECTED_DISPLAYS[@]}"; do
    /usr/bin/xrandr --output "$EDISPLAY" --off
    echo "Turned off disconnected display: $EDISPLAY" >> $LOGFILE
done


# Check if the laptop lid is closed
LID_STATE=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')
echo "Lid state: $LID_STATE" >> $LOGFILE

if [ "$LID_STATE" == "closed" ]; then
    # If the lid is closed, turn off the internal display
  /usr/bin/xrandr --output "$INTERNAL_DISPLAY" --off
  echo "Internal display turned off because lid is closed" >> $LOGFILE
 
  # Arrange external displays next to each other
  PREV_DISPLAY=${EXTERNAL_DISPLAYS[0]}
  /usr/bin/xrandr --output "$PREV_DISPLAY" --auto --primary
 
  for EDISPLAY in "${EXTERNAL_DISPLAYS[@]:1}"; do
      /usr/bin/xrandr --output "$EDISPLAY" --auto --right-of "$PREV_DISPLAY"
      PREV_DISPLAY=$EDISPLAY
  done
 
  echo "Configured external displays next to each other" >> $LOGFILE
else
    # If the lid is open, configure the internal and external displays next to each other
    /usr/bin/xrandr --output "$INTERNAL_DISPLAY" --auto --primary

    PREV_DISPLAY=$INTERNAL_DISPLAY
    for EDISPLAY in "${EXTERNAL_DISPLAYS[@]}"; do
      echo "Attempting to configure $EDISPLAY" >> $LOGFILE
      /usr/bin/xrandr --output $EDISPLAY --auto --right-of $PREV_DISPLAY
      PREV_DISPLAY=$EDISPLAY
    done
    echo "Configured displays: $INTERNAL_DISPLAY (primary) and external displays next to it" >> $LOGFILE
fi

# Log the final xrandr configuration
/usr/bin/xrandr >> $LOGFILE 2>&1

echo "---------------------------" >> $LOGFILE

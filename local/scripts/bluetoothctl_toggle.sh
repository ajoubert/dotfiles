#!/usr/bin/env bash

srcfile="$(dirname "$0")/private/bluetooth_device";
source $srcfile;

if [ -z "$device" ]
then
      echo "\$device is missing. Please create a file $srcfile with the line device='<your-bluetooth-device-id'"
      notify-send "Bluetoothctl error" "Impossible to connect - run bluetoothctl_toggle.sh manually for more information." --icon=dialog-error
      exit 1;
fi


if bluetoothctl info "$device" | grep 'Connected: yes' -q; then
    notify-send -t 1000 'Disconnecting' 'Disconnecting from device.' --icon=dialog-information
    bluetoothctl disconnect "$device"
    notify-send -t 1000 'Disconnected' 'Successfully disconnected' --icon=dialog-information
else
    notify-send -t 1000 'Connecting' 'Connecting to device.' --icon=dialog-information
    bluetoothctl connect "$device"
    notify-send -t 1000 'Connecting' 'Successfully connected' --icon=dialog-information
fi

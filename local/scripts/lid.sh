#!/bin/sh

#Get folder where the scripts are located

FOLDER=$(dirname $(readlink -f $0))

LOGFILE=/tmp/lid.log

echo "--- $(date) ---" >> $LOGFILE
if grep -q closed /proc/acpi/button/lid/LID0/state; then
    echo "Lid closed" >> $LOGFILE
  if [ "$(cat /sys/class/power_supply/ADP0/online)" -eq 1 ]; then
    echo "Laptop is on AC power, calling monitor update." >> $LOGFILE
    $FOLDER/monitorhotplug.sh >> $LOGFILE &>>$LOGFILE
  else
    echo "Laptop is on battery, suspending" >> $LOGFILE
    ## systemctl suspend
  fi
else
    echo "Lid opened, calling monitor update" >> $LOGFILE
    $FOLDER/monitorhotplug.sh >> $LOGFILE &>>$LOGFILE
fi
echo "-------------------------" >> $LOGFILE
 

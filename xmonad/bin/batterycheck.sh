#!/bin/bash -ex
# inspired by https://bbs.archlinux.org/viewtopic.php?id=67425
#
# low battery in %
LOW_BATTERY="10"
 #critical battery in % (execute action)
CRITICAL_BATTERY="5"
 #acpi battery name
BAT="BAT0"
 #action
ACTION="/usr/sbin/pm-suspend"
 #display icon
ICON="/usr/share/icons/gnome/48x48/devices/battery.png"

if [ -e "/proc/acpi/battery/$BAT" ]; then
    MAX_BATTERY=$(cat /proc/acpi/battery/BAT0/info | grep 'last full' | awk '{print$4}')
    LOW_BATTERY=$(($LOW_BATTERY*$MAX_BATTERY/100))
    CRITICAL_BATTERY=$(($CRITICAL_BATTERY*$MAX_BATTERY/100))

    if [ -e "/proc/acpi/battery/$BAT/state" ]; then
        PRESENT=$(grep "present:" /proc/acpi/battery/$BAT/state | awk '{print $2}')
        if [ "$PRESENT" = "yes" ]; then

            STATE=$(grep "charging state" /proc/acpi/battery/$BAT/state | awk '{print $3}')
            CAPACITY=$(grep "remaining capacity" /proc/acpi/battery/$BAT/state | awk '{print $3}')

            if [ "$CAPACITY" -lt "$LOW_BATTERY" ] && [ "$STATE" = "discharging" ]; then
                DISPLAY=:0.0 notify-send -u critical -t 5000 -i "$ICON" "Battery IS low. Plug or Pray." "remaining $CAPACITY mah, shutdown @ $CRITICAL_BATTERY mah"
            fi

            if [ "$CAPACITY" -lt "$CRITICAL_BATTERY" ] && [ "$STATE" = "discharging" ]; then
                $($ACTION)
            fi
        fi
    fi
fi

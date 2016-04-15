#!/bin/bash
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

BATTERY_PATH="/sys/class/power_supply/$BAT"

if [ -e "$BATTERY_PATH" ]; then
    if [ -e "$BATTERY_PATH/energy_full" ]; then
        MAX_BATTERY=$(cat $BATTERY_PATH/energy_full)
        LOW_BATTERY=$(($LOW_BATTERY * $MAX_BATTERY / 100))
    else
        MAX_BATTERY=$(cat $BATTERY_PATH/charge_full)
        LOW_BATTERY=$(($LOW_BATTERY * $MAX_BATTERY / 100))
    fi
    CRITICAL_BATTERY=$(($CRITICAL_BATTERY * $MAX_BATTERY/100))

    PRESENT=$(cat "$BATTERY_PATH/present")
    if [ "$PRESENT" = "1" ]; then

        STATE=$(cat "$BATTERY_PATH/status")
        if [ -e "$BATTERY_PATH/energy_now" ]; then
            CAPACITY=$(cat "$BATTERY_PATH/energy_now")
        else
            CAPACITY=$(cat "$BATTERY_PATH/charge_now")
        fi
        PERCENTAGE=$(cat "$BATTERY_PATH/capacity")

        echo "Percentage: $PERCENTAGE"
        if [ "$CAPACITY" -lt "$LOW_BATTERY" ] && [ "$STATE" = "Discharging" ]; then
            DISPLAY=:0.0 notify-send -u critical -t 5000 -i "$ICON" "Battery low at $PERCENTAGE%" "with $CAPACITY mah remaining, shutdown @ $CRITICAL_BATTERY mah"
        fi

        if [ "$CAPACITY" -lt "$CRITICAL_BATTERY" ] && [ "$STATE" = "Discharging" ]; then
            DISPLAY=:0.0 notify-send -u critical -t 5000 -i "$ICON" "Battery critical, suspending now"
            sleep 5
            sudo $ACTION
        fi
    fi
fi

#!/usr/bin/env bash
DIRECTION=$1
DIR=$(cd $(dirname "$0"); pwd)

name_test=$(amixer | grep Master)
if [[ $? == 0 ]]; then
    mixer_name="Master"
else
    mixer_name="PCM"
fi

amixer -q set $mixer_name 5%$DIRECTION

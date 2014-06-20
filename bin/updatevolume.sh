#!/usr/bin/env bash

DIRECTION=$1
SINK=$(pacmd list-sinks | grep "\* index" | head -n 1 | cut -f 2 -d :)
pactl set-sink-volume $SINK -- $DIRECTION"5%"

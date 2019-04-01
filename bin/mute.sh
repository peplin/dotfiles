#!/usr/bin/env bash
SINK=$(pacmd list-sinks | grep "\* index" | head -n 1 | cut -f 2 -d :)
pactl set-sink-mute $SINK toggle

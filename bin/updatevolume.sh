#!/usr/bin/env bash

DIRECTION=$1
pactl set-sink-volume 0 -- $DIRECTION"5%"

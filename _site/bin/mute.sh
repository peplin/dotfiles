#!/usr/bin/env bash
DIRECTION=$1
DIR=$(cd $(dirname "$0"); pwd)

amixer -q sset Master toggle
$DIR/updatevolume.sh

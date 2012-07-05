#!/usr/bin/env bash
DIRECTION=$1
DIR=$(cd $(dirname "$0"); pwd)

amixer -q set Master 5%$DIRECTION

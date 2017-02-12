#!/usr/bin/env bash

( slock && xset dpms 0 0 360 ) &
xset dpms 0 0 2
xset dpms force off

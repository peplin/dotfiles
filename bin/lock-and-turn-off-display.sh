#!/usr/bin/env bash

# Lock the screen and set it up to restore DPMS settings when unlocked
( slock && xset dpms 0 0 900 ) &

# Turn off the screen right now
xset dpms 0 0 2
xset dpms force off

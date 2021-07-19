#!/bin/bash
WAV="$1"
if [ -z "$WAV" ]; then
    echo "Usage: $0 OUTPUT.WAV" >&2
    exit 1
fi
rm -f "$WAV"

# Get sink monitor:
MONITOR=$(pactl list | egrep -A2 '^(\*\*\* )?Source #' | \
    grep 'Name: .*\.monitor$' | awk '{print $NF}' | tail -n1)
echo "set-source-mute ${MONITOR} false" | pacmd >/dev/null

# Record it raw, and convert to a wav
echo "Recording from ${MONITOR} to $WAV ..."
echo "Close this window to stop"
parec -d "$MONITOR" | sox -t raw -r 44k -b 16 -e signed -c 2 - "$WAV"

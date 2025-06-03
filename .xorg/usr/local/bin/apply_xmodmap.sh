#!/bin/bash

set -euo pipefail

if xset q | grep -q "Caps Lock: *on"; then
    # If caps lock is on, turn it off
    xdotool key Caps_Lock
fi

# Apply xmodmap settings
sudo -u $USER xmodmap /home/$USER/.Xmodmap

# Log for debugging
logger "Applied xmodmap settings for user $USER on display $DISPLAY"

#!/bin/sh

set -euo pipefail

# Lock screen with swaylock
swaylock -c 000000 &

sleep 2

# More frequent checks - turn off display every 30 seconds
while [ $(pgrep swaylock | wc -l) -ne 0 ]; do
    echo "hello from swaylock!"
    sleep 30
    # swaymsg "output * power off"
done

echo "OUTSIDE!"
# swaymsg "output * power on"

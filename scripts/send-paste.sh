#!/bin/bash

set -euo pipefail

focused_app=$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .app_id')

if [[ "$focused_app" == "Alacritty" ]]; then
    wtype -M ctrl -M shift -k v
else
    wtype -M ctrl -k v
fi

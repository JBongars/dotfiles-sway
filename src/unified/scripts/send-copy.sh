#!/bin/bash

set -euo pipefail

focused_app=$($I3_MSG -t get_tree | jq -r '.. | select(.focused?) | .app_id')

if [[ "$focused_app" == "Alacritty" ]]; then
    wtype -M ctrl -M shift -k c
else
    wtype -M ctrl -k c
fi

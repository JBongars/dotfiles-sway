#!/bin/sh
set -eu

focused_app=$($I3_MSG -t get_tree | jq -r '.. | select(.focused?) | .app_id')

if echo "$focused_app" | grep -q "firefox"; then
    case "$1" in
        "BTN_SIDE"|"button8")
            wtype -M ctrl -k w -m ctrl
            ;;
        "BTN_EXTRA"|"button9")
            wtype -M ctrl -M shift -k t -m shift -m ctrl
            ;;
    esac
fi

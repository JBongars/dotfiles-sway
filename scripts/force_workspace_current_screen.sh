#!/bin/sh

# Get the currently focused output (screen)
FOCUSED_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused==true).name')

# Move the requested workspace to the currently focused output, then switch to it
swaymsg "workspace number $1; move workspace to output $FOCUSED_OUTPUT"

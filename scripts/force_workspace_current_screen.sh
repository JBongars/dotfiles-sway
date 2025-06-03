#!/bin/sh

# Get the currently focused output (screen)
FOCUSED_OUTPUT=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true).output' | tr -d '"')

# Switch to the requested workspace on the currently focused output
swaymsg "workspace $1; move workspace to output --no-auto-back-and-forth $FOCUSED_OUTPUT"

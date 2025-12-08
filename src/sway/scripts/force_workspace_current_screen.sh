#!/bin/sh

# Get the currently focused output (screen)
FOCUSED_OUTPUT=$($I3_MSG -t get_outputs | jq -r '.[] | select(.focused==true).name')

# Move the requested workspace to the currently focused output, then switch to it
$I3_MSG "workspace number $1; move workspace to output $FOCUSED_OUTPUT"

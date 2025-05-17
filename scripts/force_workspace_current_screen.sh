#!/bin/bash

# Get the currently focused output (screen)
FOCUSED_OUTPUT=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).output' | tr -d '"')

# Switch to the requested workspace on the currently focused output
i3-msg "workspace $1; move workspace to output --no-auto-back-and-forth $FOCUSED_OUTPUT"

#!/bin/bash

# Static commands
static_commands="border toggle
focus left
focus right
focus up
focus down
focus parent
layout toggle
layout tabbed
fullscreen toggle
floating toggle
kill
reload"

# Dynamic workspaces
workspaces=$($I3_MSG -t get_workspaces | jq -r '.[].name' | sed 's/^/workspace /')

# Combine and sort
all_commands=$(printf "%s\n%s" "$static_commands" "$workspaces" | sort)

selected=$(echo "$all_commands" | wofi --dmenu --prompt "Sway: " --height 400 --width 300)

if [ -n "$selected" ]; then
    $I3_MSG "$selected"
fi

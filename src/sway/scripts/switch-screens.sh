#!/bin/bash

# Get list of outputs and their visible workspaces
outputs=($(swaymsg -t get_outputs -r | jq -r '.[] | select(.active) | .name'))
declare -A visible_ws

# Get the visible workspace on each output
for output in "${outputs[@]}"; do
    visible_ws[$output]=$(swaymsg -t get_workspaces -r | jq -r --arg o "$output" '.[] | select(.output == $o and .visible) | .name')
done

# Remember which workspace we're on
current_ws=$(swaymsg -t get_workspaces -r | jq -r '.[] | select(.focused) | .name')

# Rotate: each workspace moves to the next output
num_outputs=${#outputs[@]}
for ((i=0; i<num_outputs; i++)); do
    next_output=${outputs[$(( (i+1) % num_outputs ))]}
    ws=${visible_ws[${outputs[$i]}]}
    swaymsg "[workspace=$ws]" move workspace to output "$next_output"
done

# Refocus original workspace
swaymsg workspace "$current_ws"

#!/bin/bash
set -eu
set -x

# Function to check if workspace is empty
is_workspace_empty() {
    local workspace=$1
    local count=$($I3_MSG -t -r get_tree | jq ".nodes[].nodes[].nodes[] | select(.name==$workspace) | .nodes | length")
    [ "$count" -eq 0 ]
}

# Kill workspace 3,4,5
$I3_MSG '[workspace=3] kill' || :
$I3_MSG '[workspace=4] kill' || :
$I3_MSG '[workspace=5] kill' || :

# Open in workspace 8
./force_workspace_current_screen.sh 8
if is_workspace_empty "8"; then
    /opt/google/chrome/chrome --profile-directory="Default" --restore-last-session &
fi

# Open in workspace 1
./force_workspace_current_screen.sh 1
if is_workspace_empty "1"; then
    /bin/alacritty -e bash -c 'tmux attach || tmux' &
fi
$I3_MSG 'move workspace to output right'

# Open in workspace 9
./force_workspace_current_screen.sh 9
if is_workspace_empty "9"; then
    /opt/google/chrome/chrome --profile-directory="Default" --restore-last-session &
fi

# Wait for applications to start
sleep 2

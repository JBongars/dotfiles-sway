#!/bin/bash

# Graceful logout script for sway
# 1. Immediately lock screen with goodbye message
# 2. Attempt graceful sway exit
# 3. Wait 10 seconds
# 4. Force terminate remaining apps

# Step 1: Immediately lock screen with goodbye message
swaylock -f \
    --config "$HOME/.config/sway/.swaylock/config" \
    --screenshots \
    --ignore-empty-password \
    --daemonize \
    --clock \
    --indicator-idle-visible \
    --indicator \
    --timestr "Good bye." \
    --datestr "" \

# Give swaylock a moment to initialize
sleep 0.5

# Step 2: Attempt graceful sway exit
swaymsg exit &
SWAY_PID=$!

# Step 3: Wait up to 10 seconds for graceful exit
for i in {1..10}; do
    if ! pgrep -x sway > /dev/null; then
        # Sway has exited gracefully
        exit 0
    fi
    sleep 1
done

# Step 4: Force terminate session if sway hasn't exited
echo "Graceful exit timeout - forcing session termination"
loginctl terminate-session $XDG_SESSION_ID

#!/bin/bash

# Script to launch Firefox with a specific profile, creating it if it doesn't exist
# Save this as ~/.local/bin/firefox-profile.sh and make it executable with: chmod +x ~/.local/bin/firefox-profile.sh

PROFILE_NAME="$1"
if [ -z "$PROFILE_NAME" ]; then
  # If no profile specified, just launch Firefox normally
  exec firefox -ProfileManager
fi

# Firefox profiles are stored in ~/.mozilla/firefox/
PROFILE_DIR=~/.mozilla/firefox
PROFILES_INI="$PROFILE_DIR/profiles.ini"

# Check if the profile exists in profiles.ini
if ! grep -q "Name=$PROFILE_NAME" "$PROFILES_INI" 2>/dev/null; then
  firefox -CreateProfile "$PROFILE_NAME" &>/dev/null
  sleep 1
fi

# Launch Firefox with the specified profile
exec firefox -P "$PROFILE_NAME" --restore-session

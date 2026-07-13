#!/usr/bin/env sh

set -eou pipefail

# BACKGROUND_IMAGE="--screenshots"
BACKGROUND_IMAGE="--image \"${HOME}/wallpaper.jpg\""

swaylock -f \
    --config "$HOME/.config/.swaylock/config" \
    $BACKGROUND_IMAGE \
    --ignore-empty-password \
    --daemonize \
    --indicator-caps-lock \
    --indicator \
    --clock \
    --timestr "%H:%M" \
    --datestr "%d-%m-%Y" \
    --show-failed-attempts \
    --indicator-idle-visible


#!/usr/bin/env sh

set -eou pipefail

swaylock -f \
    --config "$HOME/.config/sway/.swaylock/config" \
    --screenshots \
    --ignore-empty-password \
    --daemonize \
    --indicator-caps-lock \
    --indicator \
    --clock \
    --timestr "%Hh %Mm %Ss" \
    --datestr "%b-%d-%Y" \
    --show-failed-attempts \
    --indicator-idle-visible

#!/bin/sh

if [ -n "$SWAYSOCK" ]; then
    export I3_MSG=swaymsg
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export XDG_SESSION_TYPE=wayland
else
    export XDG_CURRENT_DESKTOP=i3
    export XDG_SESSION_DESKTOP=i3
    export DG_SESSION_TYPE=x11
    export I3_MSG=i3-msg
fi

[ -d "$HOME/.config/sway" ] && I3_CONFIG="$HOME/.config/sway" || \
    [ -d "$HOME/.config/i3" ] && I3_CONFIG="$HOME/.config/i3"

export I3_CONFIG
export I3_SCRIPTS="$I3_CONFIG/scripts"

[ $# -gt 0 ] && exec $@

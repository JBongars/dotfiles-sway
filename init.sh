#!/bin/bash

BASE_CONFIG_PATH="$(cd "$(dirname "$0")" && pwd)"
UNIFIED_CONFIG_PATH="${BASE_CONFIG_PATH}/unified/config"

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    DE="sway"
    DE_CONFIG_PATH="${BASE_CONFIG_PATH}/sway/config"

else
    DE="i3"
    DE_CONFIG_PATH="${BASE_CONFIG_PATH}/i3/config"
fi

# echo "$(find "./${DE}/config" -type f)
# $(find "./unified/config/" -type f)" | sort -t/ -k4 | xargs cat > config

{
    echo "#"
    figlet -f small "sway/i3 config" | sed 's/^/# /'
    echo "# GENERATED AUTOMATICALLY - DO NOT EDIT"
    echo "# $(printf '═%.0s' {1..50})"
    echo ""
    {
        find "${DE_CONFIG_PATH}" -type f -printf '%f\t%p\n'
        find "${UNIFIED_CONFIG_PATH}" -type f -printf '%f\t%p\n'
    } | sort | cut -f2- | while read -r f; do    
        echo ""
        # figlet -f small "${f##*/}" | sed 's/^/# /'
        echo "# $f"
        echo "# $(printf '─%.0s' {1..50})"
        echo ""
        cat "$f"
    done
} > config

# pipx j2 ~/.config/wm/config.j2 -o "$OUTPUT" -e DE="$DE"

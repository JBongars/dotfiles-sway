#!/bin/bash

BASE_CONFIG_PATH="$(cd "$(dirname "$0")" && pwd)"
BASE_SOURCE_PATH="${BASE_CONFIG_PATH}/src"
UNIFIED_CONFIG_PATH="${BASE_SOURCE_PATH}/unified/config"

function generate_config(){
    local de=$1
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
    } > "${BASE_CONFIG_PATH}/config-i3"
}
DE="i3"
DE_CONFIG_PATH="${BASE_SOURCE_PATH}/i3/config"

generate_config

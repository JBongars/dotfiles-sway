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
    } > "${BASE_CONFIG_PATH}/config"
}

function install(){
    local de="$1"
    ( cd "${BASE_SOURCE_PATH}/${de}" && \
        stow -R -t $BASE_CONFIG_PATH dotfiles
        stow -R -t "${BASE_CONFIG_PATH}/scripts" --adopt scripts && chmod -R +x "${BASE_CONFIG_PATH}/scripts"
    )
}

function install_sway() {
    install "unified"
    install "sway"
    ( cd "${HOME}/.config" && ln --symbolic "$BASE_SOURCE_PATH/sway/dotfiles/.avizo" "./avizo" 2> >(sed 's/^/WARNING: /') )


}

function install_i3() {
    install "unified"
    install "i3"
}

[ -d "${BASE_CONFIG_PATH}/scripts" ] || mkdir "${BASE_CONFIG_PATH}/scripts"

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    DE="sway"
    DE_CONFIG_PATH="${BASE_SOURCE_PATH}/sway/config"

    generate_config
    install_sway
else
    DE="i3"
    DE_CONFIG_PATH="${BASE_SOURCE_PATH}/i3/config"

    generate_config
    install_i3
fi

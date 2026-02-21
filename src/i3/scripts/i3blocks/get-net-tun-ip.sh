#!/bin/sh
set -eu

nmcli con show | grep "tun" | awk '{print $1}' | while read elem; do
    printf "| %s = %s " "$elem" "$(nmcli con show "$elem" | grep 'ipv4.address' | awk '{print $2}')"
done
printf "\n"

#!/bin/sh
CACHE_FILE="$HOME/.cache/location"

if [ ! -f "$CACHE_FILE" ]; then
    data=$(wget -qO- "https://ipapi.co/json")
    lat=$(echo "$data" | jq '.latitude')
    lon=$(echo "$data" | jq '.longitude')
    echo "$lat:$lon" > "$CACHE_FILE"
fi

cat "$CACHE_FILE"

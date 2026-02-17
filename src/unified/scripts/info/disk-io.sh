#!/usr/bin/env bash
# Disk I/O speeds and busy percentage using iostat

DISK="${BLOCK_INSTANCE:-vda}"
LABEL="${LABEL:-}"
ALERT_HIGH="${ALERT_HIGH:-80}"

# Get real-time iostat output (second sample shows activity during that 1 second)
line=$(iostat -dx "$DISK" 1 2 | grep "$DISK" | tail -1)

read_speed=$(echo "$line" | awk '{print $2}')
write_speed=$(echo "$line" | awk '{print $8}')
busy=$(echo "$line" | awk '{print $22}')

# Format read speed
if (( $(echo "$read_speed >= 1024" | bc -l) )); then
    read_fmt=$(printf "%.1fM" $(echo "$read_speed / 1024" | bc -l))
else
    read_fmt=$(printf "%.0fK" "$read_speed")
fi

# Format write speed
if (( $(echo "$write_speed >= 1024" | bc -l) )); then
    write_fmt=$(printf "%.1fM" $(echo "$write_speed / 1024" | bc -l))
else
    write_fmt=$(printf "%.0fK" "$write_speed")
fi

# Format busy percentage
busy_int=$(printf "%.0f" "$busy")

# Full text
echo "${LABEL}R:${read_fmt} W:${write_fmt} ${busy_int}%"
# Short text
echo "${LABEL}R:${read_fmt} W:${write_fmt} ${busy_int}%"

# Color based on busy percentage
if [ "$busy_int" -ge "$ALERT_HIGH" ]; then
    echo "#FF0000"
elif [ "$busy_int" -ge $((ALERT_HIGH / 2)) ]; then
    echo "#FFFC00"
fi

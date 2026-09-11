#!/usr/bin/env bash

set -euo pipefail

# pkill waybar
# sleep 0.1
# waybar -c $HOME/.waybar/config -s $HOME/.waybar/style.css
#
# with debugging
#
# Launch waybar with logging; restart it if it dies.

LOGDIR="$HOME/.logs"
LOG="$LOGDIR/waybar.log"
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/waybar-launch.pid"
mkdir -p "$LOGDIR"

log() { echo "=== $(date '+%F %T') $* ===" >> "$LOG"; }

# Stop a previous launcher (from an earlier sway reload) and any stray waybar
[ -f "$PIDFILE" ] && kill "$(cat "$PIDFILE")" 2>/dev/null
pkill -x waybar || true
sleep 0.3
echo $$ > "$PIDFILE"

# Make sure a crash produces a core dump for systemd-coredump
ulimit -c unlimited

# Rotate the log at ~20 MB
if [ -f "$LOG" ] && [ "$(stat -c %s "$LOG")" -gt 20000000 ]; then
    mv "$LOG" "$LOG.old"
fi

# If this launcher is stopped (e.g. by a reload), stop its waybar and exit
trap 'log "launcher stopped"; kill "$child" 2>/dev/null; exit 0' TERM INT

while true; do
    log "starting waybar"
    waybar -l debug \
        -c "$HOME/.config/sway/.waybar/config" \
        -s "$HOME/.config/sway/.waybar/style.css" >> "$LOG" 2>&1 &
    child=$!
    wait "$child"
    rc=$?

    if [ "$rc" -gt 128 ]; then
        log "waybar DIED: signal $(kill -l $((rc - 128))) (exit $rc)"
    else
        log "waybar DIED: exited with code $rc"
    fi

    # Record which outputs existed at the moment it died
    swaymsg -t get_outputs 2>&1 | grep '^Output' >> "$LOG"

    # If sway itself is gone, don't loop forever
    swaymsg -t get_version >/dev/null 2>&1 || { log "sway gone, exiting"; exit 0; }

    sleep 2
done

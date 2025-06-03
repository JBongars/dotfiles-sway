#!/bin/sh

# Lock screen with LightDM
dm-tool lock &

# Get the PID of the greeter process
sleep 1
GREETER_PID=$(pgrep -f lightdm-greeter)

# Monitor if the greeter is running and force display off periodically
while [ $(pgrep -f lightdm-greeter | wc -l) -ne 0 ];
do
    sleep 120 # 2 mins
    swaymsg "output * dpms off"
done

I3_CONFIG_FILE=$I3_CONFIG/config
mod_key=$(sed -nre 's/^set \$mod (.*)/\1/p' ${I3_CONFIG_FILE})
grep "^bindsym" ${I3_CONFIG_FILE} \
    | sed 's/bindsym //' \
    | wofi -dmenu -theme ~/.config/sway/.rofi/rofikeyhint.rasi

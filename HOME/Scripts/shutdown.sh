#/bin/bash

if [ $(printf "No\nYes\n" | rofi -dmenu -p "Shutdown? ") = "Yes" ]; then
    systemctl poweroff
fi

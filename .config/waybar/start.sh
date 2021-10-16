#!/bin/bash

killall -q waybar
while pgrep -x waybar > /dev/null; do sleep 0.1; done
if [[ -s "$(which waybar)" ]]; then 
	dunstify -a "waybar" "Starting up waybar"
	exec waybar -c ~/.config/waybar/config
fi

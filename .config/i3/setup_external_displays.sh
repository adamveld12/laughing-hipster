#!/bin/bash

PRIMARY=$(xrandr | grep -i -e "eDP.* connected" | awk '{ print $1 }')
SECONDARY=$(xrandr | grep -m 1 "^DP-[0-9] connected" | awk '{ print $1 }')
BACKGROUND=~/Pictures/Wallpapers/logo.svg

if [ "$1" = "CONNECT" ]; then
    xrandr --output "${SECONDARY}" --auto --right-of ${PRIMARY} --dpi 165;
    nitrogen --head=2 --save --set-color=#FFFFFF --set-centered "${BACKGROUND}";
    nitrogen --head=1 --save --set-color=#FFFFFF --set-centered "${BACKGROUND}";
elif [ "$1" = "DISCONNECT" ]; then
    xrandr --output "${SECONDARY}" --off;
elif [ "$1" = "RECONNECT_PRIMARY" ]; then
    xrandr --output ${PRIMARY} --off;
elif [ "$1" = "OFF" ]; then
    xrandr --output ${PRIMARY} --off;
else
    set +x;
    exit 1;
fi

sleep 1;
xrandr --output ${PRIMARY} --auto --primary --preferred --dpi 100 --filter bilinear;
nitrogen --head=0 --save --set-color=#FFFFFF --set-centered ${BACKGROUND};


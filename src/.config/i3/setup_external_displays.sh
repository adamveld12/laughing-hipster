#!/bin/bash

PRIMARY=$(xrandr | grep primary | awk '{ print $1 }')
SECONDARY=$(xrandr | grep "DVI.*" | awk '{ print $1 }')
BACKGROUND=~/Pictures/Wallpapers/retro.jpg

if [ "$1" = "CONNECT" ]; then
    xrandr --output ${SECONDARY} --auto --above ${PRIMARY} --dpi 165;
    nitrogen --head=1 --save --set-scaled "${BACKGROUND}";
elif [ "$1" = "DISCONNECT" ]; then
    xrandr --output ${SECONDARY} --off;
elif [ "$1" = "RECONNECT_PRIMARY" ]; then
    xrandr --output ${PRIMARY} --off;
else
    set +x;
    exit -1;
fi

sleep .5;
xrandr --output ${PRIMARY} --auto --primary --preferred --dpi 100 --filter bilinear;
nitrogen --head=0 --save --set-scaled ${BACKGROUND};


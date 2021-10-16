#!/bin/bash
killall -q polybar
while pgrep -x polybar > /dev/null; do sleep 0.1; done


BACKGROUND=~/Pictures/Wallpapers/logo.svg

PRIMARY=$(xrandr | grep -i -e "eDP.* connected" | awk '{ print $1 }')
MONITOR=${PRIMARY} polybar 1080p-bottom &
MONITOR=${PRIMARY} polybar 1080p-top &
nitrogen --head=0 --save --set-color=#FFFFFF --set-centered ${BACKGROUND};

SECONDARY=$(xrandr | grep "^DP-[0-9] connected" | awk '{ print $1 }')
if [ ! -z "${SECONDARY}" ]; then
    nitrogen --head=1 --save --set-color=#FFFFFF --set-centered ${BACKGROUND};
    nitrogen --head=2 --save --set-color=#FFFFFF --set-centered ${BACKGROUND};
    nitrogen --head=3 --save --set-color=#FFFFFF --set-centered ${BACKGROUND};
    MONITOR=${SECONDARY} polybar 1080p-bottom &
    MONITOR=${SECONDARY} polybar 1080p-top &
fi

#!/bin/bash
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.1; done

PRIMARY=$(xrandr | grep primary | awk '{ print $1 }')
MONITOR=${PRIMARY} polybar 1080p-bottom &
MONITOR=${PRIMARY} polybar 1080p-top &

SECONDARY=$(xrandr | grep "DVI.*connected" | awk '{ print $1 }')
MONITOR=${SECONDARY} polybar 4k-bottom &
MONITOR=${SECONDARY} polybar 4k-top &

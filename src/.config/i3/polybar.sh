#!/bin/bash
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

# MONITOR=DP-0 polybar 4k-bottom &
MONITOR=eDP-1 polybar 1080p-bottom &
MONITOR=eDP-1 polybar 1080p-top &

#!/bin/bash
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=DP-0 polybar bar1 &
MONITOR=DVI-I-1-1 polybar bar1 &
MONITOR=DVI-I-2-2 polybar bar1 &

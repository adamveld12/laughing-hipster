#!/bin/bash

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

MONITOR=eDP-1-1 polybar bar1 &
MONITOR=DVI-I-3-2 polybar bar1 &
MONITOR=DVI-I-2-1 polybar bar1 &

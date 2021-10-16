#!/bin/bash

killall -q picom
while pgrep -x picom >/dev/null; do sleep 1; done
picom -C -f --no-fading-openclose --config /dev/null -b

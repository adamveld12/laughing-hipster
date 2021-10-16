#!/bin/bash

killall -q dunst
while pgrep -x dunst >/dev/null; do sleep 0.1; done

dunst -config ~/.config/dunst/dunstrc

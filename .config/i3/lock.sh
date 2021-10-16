#!/bin/bash
i3lock-fancy -f 'Pragmata Pro' -t 'Type Password To Unlock';

if [ "$1" = "SUSPEND" ]; then
    systemctl suspend;
if

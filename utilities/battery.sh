#!/bin/bash
percent=`ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%d", $10/$5 * 100)}'`
if   (( percent > 90 )); then color='#[bright fg=green]'
elif (( percent > 80 )); then color='#[nobright fg=green]'
elif (( percent > 70 )); then color='#[bright fg=yellow]'
elif (( percent > 30 )); then color='#[bright red]'
                         else color='#[nobright red]'
fi

echo "$color$percent%"

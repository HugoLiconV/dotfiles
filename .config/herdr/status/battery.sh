#!/bin/zsh
# Battery level with a charging/discharging icon
line=$(pmset -g batt | grep '%')
pct=$(print -r -- $line | grep -Eo '[0-9]+%')
if [[ $line == *"; charging"* || $line == *"; charged"* || $line == *"; finishing"* || $line == *"AC attached"* ]]; then
  icon=$'\U000f0084'
else
  icon=$'\U000f0079'
fi
printf '%s %s' $icon $pct

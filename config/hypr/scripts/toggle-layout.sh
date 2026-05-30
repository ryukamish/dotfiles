#!/bin/sh

current_layout=$(hyprctl getoption general:layout | grep 'str:' | awk '{print $2}')

if [ "$current_layout" = "dwindle" ]; then
  hyprctl eval 'hl.config({ general = { layout = "scrolling" }})'
  sleep 0.3
  notify-send "Hyprland" "Layout switched to: Scrolling" -t 2000
else
  hyprctl eval 'hl.config({ general = { layout = "dwindle" }})'
  notify-send "Hyprland" "Layout switched to: Dwindle" -t 2000
fi

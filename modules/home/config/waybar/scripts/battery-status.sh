#!/usr/bin/env bash
# ~/.config/waybar/scripts/battery-status.sh
# Показывает батарею только пока заряд < HIDE_ABOVE.

HIDE_ABOVE=80
BAT=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -n1)

[ -z "$BAT" ] && { echo '{"text":""}'; exit 0; }

capacity=$(cat "$BAT/capacity")
status=$(cat "$BAT/status")   # Charging / Discharging / Full / Not charging

icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
idx=$(( capacity / 10 ))
[ "$idx" -gt 9 ] && idx=9
icon="${icons[$idx]}"

if [ "$status" = "Charging" ]; then
    icon=""
fi

if [ "$capacity" -ge "$HIDE_ABOVE" ] && [ "$status" != "Charging" ]; then
    echo '{"text":"", "class":"hidden", "tooltip":"'"$capacity"'%"}'
    exit 0
fi

class="normal"
[ "$capacity" -le 15 ] && class="critical"
[ "$capacity" -le 30 ] && [ "$capacity" -gt 15 ] && class="warning"

echo "{\"text\":\"$icon $capacity%\", \"class\":\"$class\", \"tooltip\":\"$status, $capacity%\"}"

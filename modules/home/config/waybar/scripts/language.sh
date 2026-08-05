#!/usr/bin/env bash
# ~/.config/waybar/scripts/language.sh
# Показывает текущую раскладку клавиатуры niri.

data=$(niri msg -j keyboard-layouts)
idx=$(echo "$data" | jq -r '.current_idx')
name=$(echo "$data" | jq -r ".names[$idx]")

# Короткие подписи вместо длинных названий
case "$name" in
  *Russian*|*RU*) short="RU" ;;
  *English*|*US*) short="EN" ;;
  *) short="$name" ;;
esac

echo "{\"text\":\"$short\", \"tooltip\":\"$name\"}"

#!/usr/bin/env bash
# Мгновенный индикатор раскладки niri (без поллинга)

print_layout() {
  local data idx name short
  data=$(niri msg -j keyboard-layouts 2>/dev/null) || exit 1
  idx=$(jq -r '.current_idx // 0' <<<"$data")
  name=$(jq -r ".names[$idx] // \"\"" <<<"$data")
  case "$name" in
    *Russian*|*RU*) short="RU" ;;
    *English*|*US*) short="EN" ;;
    *) short="$name" ;;
  esac
  printf '{"text":"%s","tooltip":"%s"}\n' "$short" "$name"
}

print_layout   # начальное состояние

niri msg --json event-stream 2>/dev/null \
  | grep -E --line-buffered '"KeyboardLayout(Switched|sChanged)"' \
  | while read -r _; do print_layout; done

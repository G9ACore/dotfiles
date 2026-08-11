echo "args: $*" >> /tmp/yazi-chooser.log

out=""
dir=""
for a in "$@"; do
  if [ -z "$out" ] && [ "${a#/}" != "$a" ] && [ ! -d "$a" ]; then
    out="$a"
  elif [ -d "$a" ]; then
    dir="$a"
  fi
done
dir="${dir:-$HOME}"

export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

tmp="$(mktemp)"
@alacritty@ --class yazi-picker @yazi@ "$dir" --chooser-file="$tmp"
if [ -s "$tmp" ] && [ -n "$out" ]; then
  cp "$tmp" "$out"
fi
rm -f "$tmp"

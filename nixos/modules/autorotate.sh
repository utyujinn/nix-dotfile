#!/bin/sh
# ~/.local/bin/screen-autorotate.sh

# メインモニターを取得（最初の接続済み出力）
MONITOR=$(xrandr --query | awk '/ connected/ {print $1; exit}')

if [ -z "$MONITOR" ]; then
  echo "No connected monitor found." >&2
  exit 1
fi

# センサーの変化を監視
gdbus monitor --system --dest net.hadess.SensorProxy --object-path /net/hadess/SensorProxy |
  while IFS= read -r line; do
    case "$line" in
      *"normal"*)
        xrandr --output "$MONITOR" --rotate normal
        ;;
      *"left-up"*)
        xrandr --output "$MONITOR" --rotate left
        ;;
      *"right-up"*)
        xrandr --output "$MONITOR" --rotate right
        ;;
      *"bottom-up"*)
        xrandr --output "$MONITOR" --rotate inverted
        ;;
    esac
  done

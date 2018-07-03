#!/usr/bin/env sh

export MONITOR=$(xrandr -q|grep primary|awk {'print $1'})
SCREENS=$(xrandr -q|grep " connected"|wc -l)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [ $SCREENS -gt 1 ]; then
  polybar -c ~/.config/polybar/config.ini left &
  polybar -c ~/.config/polybar/config.ini right &
fi

polybar -c ~/.config/polybar/config.ini primary &

echo "Bars launched..."

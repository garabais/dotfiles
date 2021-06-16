#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config

	primary="$(xrandr -q | awk '/ connected/ && /primary/ { print $1 }')"

	if [[ $wm == "bspwm" ]]; then
		MONITOR=$primary polybar -l info primary-bspwm -c ~/.config/polybar/config.ini &
	else
		MONITOR=$primary polybar -l info primary -c ~/.config/polybar/config.ini &
	fi

	for secondary in $(xrandr -q | awk '/ connected/ && !/primary/ { print $1 }'); do
		if [[ $wm == "bspwm" ]]; then
			MONITOR=$secondary polybar -l info secondary-bspwm -c ~/.config/polybar/config.ini &
		else
			MONITOR=$secondary polybar -l info secondary -c ~/.config/polybar/config.ini &
		fi
	done

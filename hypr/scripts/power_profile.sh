#!/bin/bash
export XDG_RUNTIME_DIR="/run/user/1000"
HYPR_SIG=$(ls -t "$XDG_RUNTIME_DIR/hypr" 2>/dev/null | grep -v "\.lock" | head -n 1)
[ -z "$HYPR_SIG" ] && HYPR_SIG=$(ls -t /tmp/hypr 2>/dev/null | grep -v "\.lock" | head -n 1)
export HYPRLAND_INSTANCE_SIGNATURE="$HYPR_SIG"

# Configuration
LAPTOP="eDP-2"
EXT_MONITOR="HDMI-A-1"
SCALE="1.6"

# Check if External Monitor is connected
MONITOR_CONNECTED=$(/usr/bin/hyprctl monitors all | grep "$EXT_MONITOR")

if [ ! -z "$MONITOR_CONNECTED" ]; then
    # MONITOR IS CONNECTED: Disable laptop screen to force everything to Ultrawide
    /usr/bin/hyprctl keyword monitor "$LAPTOP, disable"
else
    # MONITOR DISCONNECTED: Re-enable laptop screen and handle power profile
    STATUS=$(cat /sys/class/power_supply/ADP0/online)
    if [ "$STATUS" -eq 1 ]; then
        /usr/bin/hyprctl keyword monitor "$LAPTOP, 2560x1440@165, auto, $SCALE"
    else
        /usr/bin/hyprctl keyword monitor "$LAPTOP, 2560x1440@60, auto, $SCALE"
    fi
fi
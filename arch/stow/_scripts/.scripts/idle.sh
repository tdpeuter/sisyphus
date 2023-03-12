#!/usr/bin/env bash
# Configuration of swayidle
# Just run the script

# Kill previous instances to avoid clashing
pkill swayidle

swayidle -w \
    timeout 600 \
        'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    timeout 1200 \
        'systemctl suspend' \
    before-sleep 'swaymsg "output * dpms on"; swaylock'
    # Screen needs to be turned back on or you will get a black screen after waking up again. 

#    timeout 300 \
#        "~/.scripts/wander.sh" \
#        resume 'brightnessctl -r' \

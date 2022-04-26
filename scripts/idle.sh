#!/usr/bin/env bash
# Configuratoin of swayidle
# Just run the script

pkill swayidle

swayidle -w \
    timeout 300 \
        'brightnessctl -s set 15%' \
        resume 'brightnessctl -r' \
    timeout 600 \
        'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    timeout 1200 \
        'systemctl suspend' \
    before-sleep 'swaylock -f --screenshots --clock --indicator --effect-blur 5x5'


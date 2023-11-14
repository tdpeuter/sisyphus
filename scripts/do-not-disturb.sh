#!/usr/bin/env bash
# Script to toggle Do not disturb mode for dunst

# Get current state
if [ "$( command -v dunstctl )" ]; then
    current_state="$( dunstctl is-paused )"
fi

# Toggle
if [ "${current_state}" == "false" ] ; then
    notify-send 'Hiding notifications'
    sleep 5
    # makoctl set-mode do-not-disturb
    dunstctl set-paused true
else
    # makoctl set-mode default
    dunstctl set-paused false
    notify-send 'Showing notifications'
fi

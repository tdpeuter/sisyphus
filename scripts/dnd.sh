#!/usr/bin/env bash
# Script to toggle Do not disturb mode for mako and dunst

# Permanent memory
saved_state=0

# Toggle
if [[ ${saved_state} -eq 0 ]] ; then 
    ~/.scripts/notify.sh 'Hiding notifications'
    sleep 5
    makoctl set-mode do-not-disturb
    dunstctl set-paused true
else 
    makoctl set-mode default
    dunstctl set-paused false
    ~/.scripts/notify.sh 'Showing notifications'
fi

# Update status in file
new_state=$(( (${saved_state} + 1) % 2 ))
sed -i "s/^saved_state=.*$/saved_state=${new_state}/" "${0}"


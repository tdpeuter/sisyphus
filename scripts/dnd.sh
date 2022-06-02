#!/usr/bin/env bash
# Script to toggle Do not disturb mode for mako

# Permanent memory
saved_state=0

# Toggle
if [ "${saved_state}" -eq 0 ] ; then 
    ~/.scripts/notify.sh 'Hiding notifications'
    sleep 2
    makoctl set-mode do-not-disturb
else 
    makoctl set-mode default
    ~/.scripts/notify.sh 'Showing notifications'
fi

# Update status in file
new_state=$( bc "(${saved_state} + 1) % 2" )
sed -i "s/saved_state=[0|1]/saved_state=${new_state}/" ~/.scripts/dnd.sh


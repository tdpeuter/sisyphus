#!/usr/bin/env bash
# Script to toggle black background to focus on sway

# Get instances of swaybg, except for the 'standard' one.
list=$( pgrep swaybg | head -n -1 )

if [ -z "${list}" ] ; then 
    swaybg --mode=solid_color --color=#000000 &
    # Give the previous command some time to execute
    sleep .1
    swaymsg reload
else
    # Clean up if already running
    kill $( tr ' ' '\n' <<< ${list} )
fi


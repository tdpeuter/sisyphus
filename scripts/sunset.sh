#!/usr/bin/env bash
# Script to disable for an hour or immediately continue wlsunset. 'Toggle'

# Check if wlsunset is still running
pid=$(pgrep wlsunset)

if [[ -z ${pid} ]] ; then 
        # Start wlsunset right away.
        wlsunset -l 50.50 -L 4.00 -t 3000 -T 6500 &
else
        # Currently stop wlsunset but restart in an hour. 
        kill ${pid}
        notify-send 'Stopping sunset' 'Restarting in an hour'
        at now +1 hours -f "${0}"
fi

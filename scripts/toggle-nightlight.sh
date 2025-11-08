#!/usr/bin/env bash
# Script to disable for an hour or immediately continue wlsunset. 'Toggle'

# Get current state
pid=$(pgrep wlsunset)

while getopts ":g" option; do
        case "${option}" in
                g)
                        if [[ -z "${pid}" ]]; then
                                state='active'
                                tooltip='Turn off nightlight'
                                class='activated'
                        else
                                state='inactive'
                                tooltip='Turn on nightlight'
                                class='none'
                        fi
printf '{"alt": "%s", "tooltip": "%s", "class": "%s" }' \
                                "${state}" "${tooltip}" "${class}"
                        exit 0
                        ;;
                *)
                        echo 'Invalid option'
                        exit 1
                        ;;
        esac
done

# Toggle
if [[ -z ${pid} ]] ; then 
        if [ "$( command -v wlsunset )" ]; then
                notify-send 'Starting nightlight' --app-name='twm'
                wlsunset -l 50.50 -L 4.00 -t 3000 -T 6500 &
        else
                notify-send 'Nightlight is not available'
                exit 1
        fi
else
        # Currently stop wlsunset but restart in an hour. 
        kill ${pid}
        notify-send 'Stopping sunset' 'Restarting in an hour'
        at now +1 hours -f "${0}"
fi

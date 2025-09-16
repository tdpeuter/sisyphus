#!/usr/bin/env bash
# Script to toggle Do not disturb mode for dunst

# Get current state
if [ "$( command -v dunstctl )" ]; then
    current_state="$( dunstctl is-paused )"
fi

while getopts ":g" option; do
    case "${option}" in
        g)
            if [ "${current_state}" == "false" ]; then
                state='normal'
                tooltip='Hide notifications'
                class='none'
            else
                state='paused'
                tooltip='Show notifications'
                class='activated'
            fi
            printf '{"alt": "%s", "tooltip": "%s", "class": "%s" }' \
                "${state}" "${tooltip}" "${class}"
            exit 0
            ;;
    esac
done

# Toggle
if [ "${current_state}" == "false" ] ; then
    notify-send 'Hiding notifications'
    sleep 5

    if [ "$(command -v makoctl)" ]; then
        makoctl set-mode do-not-disturb
    fi
    if [ "$(command -v dunstctl)" ]; then
        dunstctl set-paused true
    fi
else
    if [ "$(command -v makoctl)" ]; then
        makoctl set-mode default
    fi
    if [ "$(command -v dunstctl)" ]; then
        dunstctl set-paused false
    fi

    notify-send 'Showing notifications'
fi

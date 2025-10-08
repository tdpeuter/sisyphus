#!/usr/bin/env bash
# Script to toggle Do not disturb mode for dunst

STOPPED_MSG='Tailscale is stopped'

# Check if tailscale is installed
if [ ! "$( command -v tailscale )" ]; then
    echo 'Tailscale is not installed!'
    exit 1
fi

# Get current state
status="$( tailscale status )"
current_state="$( grep -o "${STOPPED_MSG}" <<< "${status}" )"

while getopts ":g" option; do
    case "${option}" in
        g)
            if [ "${current_state}" == "${STOPPED_MSG}" ]; then
                state='disconnected'
                tooltip='Connect tailnet'

                printf '{"alt": "%s", "tooltip": "%s", "class": "%s" }' \
                    "${state}" "${tooltip}" "${state}"
            else
                state='connected'
                tooltip="${status:='Disconnect tailnet'}"

                printf '{"alt": "%s", "tooltip": "<tt>%q</tt>", "class": "%s" }' \
                    "${state}" "${tooltip}" "${state}"
            fi

            exit 0
            ;;

        *)
            echo 'Invalid option'
            exit 1
            ;;
    esac
done

# Toggle
if [ "${current_state}" == "${STOPPED_MSG}" ] ; then
    notify-send 'Connecting tailnet'
    notify-send 'Connected tailnet' "$( tailscale up )"
else
    notify-send 'Disconnecting tailnet'
    notify-send 'Disconnected tailnet' "$( tailscale down )"
fi

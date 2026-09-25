#!/usr/bin/env bash

capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
status="$(cat /sys/class/power_supply/BAT0/status)"

if [ "${status}" = "Charging" ]; then
    icon="\ue55b"
elif [ "${capacity}" -ge 90 ]; then
    icon="\uf240"
elif [ "${capacity}" -ge 75 ]; then
    icon="\uf241"
elif [ "${capacity}" -ge 50 ]; then
    icon="\uf242"
elif [ "${capacity}" -ge 25 ]; then
    icon="\uf243"
else
    icon="\uf244"
fi

printf '{"text": "%s%% %s", "tooltip": "Status: %s", "class": "%s"}\n' \
    "${capacity}" "${icon}" "${status}" "${status}"

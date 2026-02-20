DURATION=20 # How long it takes to progress the bar fully
STEPS=100   # In how many steps to progress (> 0)

# Trick to fake decimals
EXP=3
interval_ms="$(( "${DURATION}" * ( 10 ** "${EXP}" ) / "${STEPS}" ))"
padded_interval_ms="$(printf "%0${EXP}d" "${interval_ms}")"
interval_s="${padded_interval_ms:0:-${EXP}}.${padded_interval_ms:-${EXP}}"

end_time="$(( "$( date '+%s' )" + "${DURATION}" ))"

# notify-send args
replace_id="${end_time}"

counter=0
while [[ "${end_time}" -gt "$( date '+%s' )" ]]; do
    # Remap to [0, 100]
    remaining_part="$(( ("${STEPS}" - "${counter}") * 100 / "${STEPS}" ))"

    notify-send \
        'Look away from your screen :)' 'RemEYEnder' \
        --hint="int:value:${remaining_part}" \
        --category='sysinfo' \
        --replace-id="${replace_id}"

    counter="$(( "${counter}" + 1 ))"
    sleep "${interval_s}"
done

notify-send \
    'Look away from your screen :)' 'RemEYEnder' \
    --hint="int:value:${remaining_part}" \
    --category='sysinfo' \
    --replace-id="${replace_id}" \
    --expire-time="${interval_ms}"


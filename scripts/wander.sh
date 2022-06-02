#!/usr/bin/env bash
# Toggle brightness to 'sleep' or 'awake', since brightnessctl does not support 
# percentages of current amount.
# Just run the script (twice)

# Permanent memory
previous=''

if [ -z "${previous}" ] ; then 
    current=$( cat /sys/class/backlight/intel_backlight/actual_brightness )
    # Doesn't have to be accurate so we can use built-in calculator.
    echo $(( current / 10 * 3 )) > /sys/class/backlight/intel_backlight/brightness
else
    echo "${previous}" > /sys/class/backlight/intel_backlight/brightness
fi

# Write to file
sed -i "s/^previous=.*$/previous=${current:-''}/" "${0}"


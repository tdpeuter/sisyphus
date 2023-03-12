#!/usr/bin/env bash
# Toggle brightness to 'sleep' or 'awake', since brightnessctl does not support 
# percentages of current amount.
# Just run the script

current=$( brightnessctl get )
# Doesn't have to be accurate so we can use built-in calculator.
brightnessctl -sq set $(( current / 10 * 3 ))


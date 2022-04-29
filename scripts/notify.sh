#!/usr/bin/env bash
# Show system status in notification, or your own message
# Syntaxis: notify [-vb] <message>

# Variables
value=0

# Get options
while getopts ":bvm:" options; do
	case "${options}" in 
		b) 	
			value=$(brightnessctl | grep -o "[0-9]*%")
			title="Brightness: ${value}"
			;;
		v)
			value=$(pactl get-sink-volume 0 | cut -d '/' -f2 | grep -o '[0-9]*%')
			# if [[ $status == "[on]" ]] ; then 
			# 	value=$(amixer get Master | grep -o "[0-9]*%" | head -n 1)
			# fi
			title="Volume: ${value:-'0%'}"
			;;
		m) 
			message=${OPTARG}
			;;
		*)	
			title="Unknown option"
			;;
	esac
done

shift $((OPTIND - 1))

notify-send "${title:-${message}}" "${message}" \
    -t 2000 \
    -c byMe \
 	-h int:value:"$(grep -o "[0-9]*" <<< "${value}")" \
	-h string:x-canonical-private-synchronous:byMe # Replace if not yet gone


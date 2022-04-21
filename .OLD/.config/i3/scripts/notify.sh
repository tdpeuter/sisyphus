#!/bin/bash
# Show system status in notification, or your own message
# Syntaxis: notify [-vb] <message>

# Variables
duration=3
value=0

# Get options
while getopts ":bvm:" options; do
	case "${options}" in 
		b) 	
			value=$(brightnessctl | grep -o "[0-9]*%")
			title="Brightness: ${value}"
			;;
		v)
			status=$(amixer get Master | grep "^  Front Left" | cut -d ' ' -f 8)
			if [[ $status == "[on]" ]] ; then 
				value=$(amixer get Master | grep -o "[0-9]*%" | head -n 1)
			fi
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
 	-h int:value:"$(grep -o "[0-9]*" <<< ${value})" \
	-h string:x-canonical-private-synchronous:byMe # Replace if not yet gone

	#-h geometry = "400x200-40-40" \
canberra-gtk-play -i audio-volume-change -d "changeVolume"

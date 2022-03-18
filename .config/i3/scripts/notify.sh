#!/bin/bash
# Show system status in notification, or your own message
# Syntaxis: notify [-vb] <message>

# Variables
duration=3
bright=''
vol=''
title=''
message=''

# Functions
function getVol () {
	status=$(amixer get Master | grep "^  Front Left" | cut -d ' ' -f 8)
	if [[ $status == "[on]" ]] ; then 
		vol=$(amixer get Master | grep -o "[0-9]*%" | head -n 1)
	else
		vol="0%"
	fi
} ; export -f getVol

# Get options
while getopts ":bvm:" options; do
	case "${options}" in 
		b) 	
			bright=$(brightnessctl | grep -o "[0-9]*%")
			title="Brightness: ${bright}"
			;;
		v)
		        getVol
			title="Volume: ${vol:-'0%'}"
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
	-h int:x:100 -h int:y:100 \
	-h string:x-canonical-private-synchronous:byMe # Replace if not yet gone

# sleep ${duration}; killall notify-osd


#!/usr/bin/env bash
# Show system status in notification, or your own message
# Syntaxis: notify [-vb] [<title> <message>]

# Get options
while getopts ":bv" options; do
	case "${options}" in 
		b) 	
			value=$(brightnessctl | grep -o "[0-9]*%")
			title="Brightness: ${value}"
            timeout=2000
			;;
		v)
			value=$(pactl get-sink-volume @DEFAULT_SINK@ | cut -d '/' -f2 | grep -o '[0-9]*%')
            status=$(amixer get Master | grep "^  Front Left" | cut -d ' ' -f 8)
            if [[ $status != "[on]" ]] ; then 
                value="Disabled"
			fi
			title="Volume: ${value:-'0%'}"
            timeout=2000
			;;
		*)	
			title="Unknown option"
			;;
	esac
done

shift $((OPTIND - 1))

# Check arguments
if [[ $# -gt 2 ]] ; then 
    >&2 echo "Syntaxis: notify [-vb] [<title> [<message>]]"
    exit 1
elif [[ $# -eq 2 ]] ; then
    title=$1
    message=$2
elif [[ $# -eq 1 ]] ; then 
    title=$1
fi

# Calculate length of coloured bar.
if [[ "${value}" =~ ^[0-9]+%$ ]] ; then 
    width=$(grep -o "[0-9]*" <<< "${value}")
fi

# Send message
notify-send "${title}" "${message}" \
    -t "${timeout:=5000}" \
    -c byMe \
 	-h int:value:"${width:=0}" \
	-h string:x-canonical-private-synchronous:byMe # Replace if not yet gone


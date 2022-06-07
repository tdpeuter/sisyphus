#!/usr/bin/env bash
# Show system status in notification, or your own message
# Syntaxis: notify [-vb] [-t <timeout>] [<title> <message>]

# Requirements: 
# - brightnessctl
# - pulsemixer

panic () {
    >&2 echo "Syntaxis: notify [-vb] [<title> [<message>]]"
    exit 1
}

# Get options
while getopts ":bvt:" options; do
	case "${options}" in 
		b) 	
			value=$( brightnessctl | grep -o "[0-9]*%" )
			title="Brightness: ${value}"
            timeout=2000
            category='sysinfo'
			;;
		v)
            # Get volume
            value="$( pulsemixer --get-volume | cut -f1 -d' ' )%"

            # If audio disabled
            if [ ! "$( pulsemixer --get-mute )" -eq 0 ] ; then 
                width=0
                value="${value} (Disabled)"
            fi

			title="Volume: ${value:-'0%'}"
            timeout=2000
            category='sysinfo'
			;;
        t)  
            timeout="${OPTARG}"
            ;;
		*)	
            panic
			;;
	esac
done

shift $((OPTIND - 1))

# Check arguments
if [ $# -gt 2 ] ; then 
    panic
elif [ $# -eq 2 ] ; then
    title=$1
    message=$2
elif [ $# -eq 1 ] ; then 
    title=$1
fi

# Calculate length of coloured bar.
if [[ "${value}" =~ ^[0-9]+%$ && "${width:--1}" -ne 0 ]] ; then 
    width=$(grep -o "[0-9]*" <<< "${value}")
fi

# Send message
notify-send "${title}" "${message}" \
    -t "${timeout:=5000}" \
    -c "${category:=''}" \
 	-h int:value:"${width:=0}" \
    -h string:wired-tag:byMe \
	-h string:x-canonical-private-synchronous:byMe # Replace if previous still exists


#!/usr/bin/env bash
# Show system status in notification, or your own message
# Syntaxis: notify [-vb] [-t <timeout>] [-p <value>] [<title> <message>]

# Requirements/dependencies: 
# - amixer
# - brightnessctl
# - libnotify (notify-send)

panic () {
    >&2 echo "Syntaxis: notify [-vb] [-t <timeout>] [-p <value>] [<title> <message>]"
    exit 1
}

# Get options
while getopts ":bvt:p:" options; do
	case "${options}" in 
		b) 	
			value=$( brightnessctl | grep -o "[0-9]*%" | tr -d '%' )
			title="Brightness: ${value}%"
            category='sysinfo'
			;;
		v)
            # Get volume (don't use pamixer because that is way slower)
            value=$( amixer sget 'Master' \
                | grep -o '\[[0-9]*%\]' \
                | tr -d '][%' \
	        | head -n1 )
            title="Volume: ${value}%"
            category='sysinfo'

            # If audio disabled, set value to zero.
	    if [ "$( amixer sget 'Master' | grep -o '\[\(on\|off\)\]' | head -n1 )" == "[off]" ] ; then 
                title="Volume: ${value}% (Disabled)"
                value=0
            fi
			;;
        t)  
            timeout="${OPTARG}"
            ;;
        p)
            value="${OPTARG}"
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
elif [ $# -gt 0 ] ; then
    title="${1}"
    message="${2:-}"
fi

# Build command string
arguments=""
if [[ ! -z "${category}" ]] ; then 
    arguments+=" -c ${category}"
fi
if [[ ! -z "${timeout}" ]] ; then 
    arguments+=" -t ${timeout}"
fi
if [[ ! -z "${value}" ]] ; then 
    arguments+=" -h int:value:${value}"
fi

notify-send "${title}" "${message}" ${arguments}


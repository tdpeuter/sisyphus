#!/usr/bin/env bash
# Take screenshots of areas, windows, or screens, interactively or immediately.
# Usage: screenshot [-t area|window|screen|all] [-a copy|save] [-i]

set -u

TARGET='area'
ACTION='copy'
INTERACTIVE='false'

DATE_STR="$( date '+%F-%H-%M-%S' )"
SAVE_DIR="${HOME}/Nextcloud/Afbeeldingen/Screenshots"

panic () {
    >&2 echo 'Usage: screenshot [-t area|window|screen|all] [-a copy|save] [-i]'
    exit 1
}

# Get options
while getopts ':t:a:i' option; do
    case "${option}" in
        t)
            if [[ "${OPTARG}" =~ ^(area|window|screen|all)$ ]]; then
                TARGET="${OPTARG}"
            else
                >&2 printf "Error: Invalid target '%s'.\n" "${OPTARG}"
                panic
            fi
            ;;
        a)
            if [[ "${OPTARG}" =~ ^(copy|save)$ ]]; then
                ACTION="${OPTARG}"
            else
                >&2 printf "Error: Invalid action '%s'.\n" "${OPTARG}"
            fi
            ;;
        i)
            INTERACTIVE='true'
            ;;
        *)
            panic
            ;;
    esac
done

if [[ "${ACTION}" == 'save' ]]; then
    SAVE_PATH="${SAVE_DIR}/${DATE_STR}.png"
else
    SAVE_PATH="/tmp/screenshot_${DATE_STR}.png"
fi

mkdir -p "${SAVE_DIR}"

if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]] && command -v hyprctl >/dev/null 2>&1 ; then
    WM='hyprland'
else
    >&2 echo 'Error: Unsupported or undetected Window Manager.'
    exit 1
fi

for tool in grim slurp wl-copy jq; do
    if ! command -v "${tool}" >/dev/null 2>&1; then
        >&2 echo "Error: Required dependency '${tool}' is missing."
        exit 1
    fi
done

# Helper functions

target_area () {
    slurp || true
}

hyprland_target_window () {
    hyprctl activewindow -j \
        | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}

hyprland_target_window_interactive () {
    local ws_id
    ws_id="$( hyprctl activeworkspace -j | jq -r '.id' )"
    hyprctl clients -j \
        | jq -r --arg ws "${ws_id}" '.[] | select(.workspace.id == ($ws | tonumber)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' \
        | slurp -d \
        || true
}

hyprland_target_screen () {
    local ws_id
    ws_id="$(hyprctl activeworkspace -j | jq -r '.id')"
    hyprctl monitors -j \
        | jq -r --arg ws "${ws_id}" '.[] | select(.activeWorkspace.id == ($ws | tonumber)) | .name'
}

hyprland_target_screen_interactive () {
    hyprctl monitors -j \
        | jq -r '.[] | "\(.x),\(.y) \(.width)x\(.height)"' \
        | slurp -d \
        || true
}

# Capturing the screenshot

GEOMETRY=''
OUTPUT=''

fetch_target_data () {
    if [[ "${TARGET}" == 'area' ]]; then
        GEOMETRY="$( target_area )"
        return 0
    fi

    local route_key="${WM}_${TARGET}_${INTERACTIVE}"

    case "${route_key}" in
        'hyprland_window_false')
            GEOMETRY="$( hyprland_target_window )"
            ;;
        'hyprland_window_true')
            GEOMETRY="$( hyprland_target_window_interactive )"
            ;;
        'hyprland_screen_false')
            OUTPUT="$( hyprland_target_screen )"
            ;;
        'hyprland_screen_true')
            GEOMETRY="$( hyprland_target_screen_interactive )"
            ;;

        *)
            >&2 echo 'Error: Unmapped execution route.'
            exit 1
            ;;
    esac
}

if [[ "${TARGET}" != 'all' ]]; then
    fetch_target_data
fi

# Detect cancellation, Escape pressed during slurp results in empty string.
if [[ "${INTERACTIVE}" == 'true' || "${TARGET}" == 'area' ]]; then
    if [[ -z "${GEOMETRY}" && -z "${OUTPUT}" ]]; then
        exit 0
    fi
fi

# Take the screenshot
if [[ -n "${GEOMETRY}" ]]; then
    grim -g "${GEOMETRY}" "${SAVE_PATH}"
elif [[ -n "${OUTPUT}" ]]; then
    grim -o "${OUTPUT}" "${SAVE_PATH}"
else
    grim "${SAVE_PATH}"
fi

# Route to clipboard
if [[ "${ACTION}" == 'copy' ]]; then
    wl-copy < "${SAVE_PATH}"
fi

# Notifications
if [[ "${TARGET}" != 'area' || "${INTERACTIVE}" == 'true' ]]; then
    NOTIF_ICON="${SAVE_PATH}"

    if command -v magick >/dev/null 2>&1; then
        THUMB_PATH="/tmp/thumb_${DATE_STR}.png"
        if magick "${SAVE_PATH}" -thumbnail '320x320^' -gravity center -extent 320x320 "${THUMB_PATH}" >/dev/null 2>&1; then
            NOTIF_ICON="${THUMB_PATH}"
        fi
    fi

    if [[ "${ACTION}" == 'copy' ]]; then
        notify-send -a 'Grim' -i "${NOTIF_ICON}" 'Screenshot Captured' 'Copied to clipboard'
    else
        notify-send -a 'Grim' -i "${NOTIF_ICON}" 'Screenshot Captured' "Saved to ${SAVE_PATH}"
    fi
fi


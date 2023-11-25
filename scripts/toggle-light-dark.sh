#!/usr/bin/env bash
# Toggle light- or dark-mode for your applications
# Usage: toggle [-m light|dark]

#################
### Variables ###
#################

THEME_LIGHT='tdpeuter-light'
THEME_DARK='tdpeuter-dark'
THEME_DEFAULT="${THEME_LIGHT}"

STATE_FILE="${HOME}/.local/state/sisyphus/theme"

declare -A theme_next
theme_next[${THEME_LIGHT}]="${THEME_DARK}"
theme_next[${THEME_DARK}]="${THEME_LIGHT}"

declare -A gsettings_alt
gsettings_alt[${THEME_LIGHT}]='default'
gsettings_alt[${THEME_DARK}]='prefer-dark'

declare -A wallpaper
wallpaper[${THEME_LIGHT}]="bg"
wallpaper[${THEME_DARK}]="bg-dark"

#############
### Logic ###
#############

# Parse options
while getopts ":m:" option; do
    case "${option}" in
        m)
            if [ "${OPTARG}" == 'light' ]; then
                theme="${THEME_LIGHT}"
            elif [ "${OPTARG}" == 'dark' ]; then
                theme="${THEME_DARK}"
            else
                >&2 printf "Error: Invalid mode: '%s'.\nShould be either 'light' or 'dark'\n" "${option}"
                exit 1
            fi
            ;;
        *)
            >&2 printf "Error: Invalid option: '%s'.\n" "${option}"
            exit 1
            ;;
    esac
done
shift $(( OPTIND - 1 ))

# Check if the state file exists
if ! [ -d "$(dirname ${STATE_FILE})" ]; then
    mkdir -p "$(dirname ${STATE_FILE})"
fi

# Choose next theme
previous_theme="$(cat ${STATE_FILE})"
if ! [[ -z "${previous_theme}" || "${theme}" ]]; then
    theme="${theme_next[${previous_theme}]}"
fi
echo "${theme:=${THEME_DEFAULT}}" > "${STATE_FILE}"

######################
### Set all themes ###
######################

# GNOME
if [ "$(command -v gsettings)" ]; then
    gsettings set org.gnome.desktop.interface color-scheme "${gsettings_alt[${theme}]}" &
fi

# Kitty
if [ "$(command -v kitty)" ]; then
    kitten themes --reload-in all --config-file-name theme.conf "${theme}" &
fi

# Sway
if [ "$(command -v swaybg)" ]; then
    pkill swaybg && swaybg --mode fill --image ~/Nextcloud/Afbeeldingen/wallpapers/${wallpaper[${theme}]} && swaymsg reload &
fi

# Vifm
if [ "$(command -v vifm)" ]; then
    echo "colorscheme ${theme} Default-256 Default" > ~/.config/vifm/theme.conf
    # Update all running instances
    vifm --remote -c "colorscheme ${theme}" &
fi

# Vim
if [ "$(command -v vim)" ]; then
    echo "colorscheme ${theme}" > ~/.vim/theme.conf
    # Update all running instances
    for server in $(vim --serverlist); do
        vim --servername "${server}" --remote-send "<C-\><C-N>:colorscheme ${theme}<CR>"
    done
fi


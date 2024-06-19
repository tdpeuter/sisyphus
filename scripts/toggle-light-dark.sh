#!/usr/bin/env bash
# Toggle light- or dark-mode for your applications
# Usage: toggle [-m light|dark] [-g]

#################
### Variables ###
#################

THEME_LIGHT='tdpeuter-light'
THEME_DARK='tdpeuter-dark'
THEME_DEFAULT="${THEME_LIGHT}"

STATE_DIR="${HOME}/.local/state/sisyphus"
STATE_FILE="${STATE_DIR}/theme"
BG_DIR="${HOME}/Nextcloud/Afbeeldingen/wallpapers"

declare -A theme_next
theme_next[${THEME_LIGHT}]="${THEME_DARK}"
theme_next[${THEME_DARK}]="${THEME_LIGHT}"

declare -A gsettings_alt
gsettings_alt[${THEME_LIGHT}]='default'
gsettings_alt[${THEME_DARK}]='prefer-dark'

declare -A gtk_theme
gtk_theme[${THEME_LIGHT}]='Adwaita'
gtk_theme[${THEME_DARK}]='Adwaita-dark'

declare -A wallpaper
wallpaper[${THEME_LIGHT}]="bg-light"
wallpaper[${THEME_DARK}]="bg-dark"

#############
### Logic ###
#############

# Parse options
while getopts ":m:g" option; do
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
        g)
            previous_theme="$(cat ${STATE_FILE})"
            if [ "${previous_theme}" == "${THEME_LIGHT}" ]; then
                class="activated"
                percentage=1
            else
                percentage=0
            fi
            printf '{ "class": "%s", "percentage": %d }' "${class}" "${percentage}"
            exit 0
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

# Update terminal colors by sending it OSC sequences.
# Alternatively, you could use theme.sh (https://github.com/lemnos/theme.sh)
# Function below loosely based on theme.sh and https://codeberg.org/dnkl/foot/issues/708
function update_terminal_colors() {
    for pid in $(pgrep zsh); do
        if [ "${theme}" == "${THEME_LIGHT}" ]; then
            printf "\033]10;#000000\007" >> /proc/${pid}/fd/0
            printf "\033]11;#ffffff\007" >> /proc/${pid}/fd/0
        elif [ "${theme}" == "${THEME_DARK}" ]; then
            printf "\033]10;#ffffff\007" >> /proc/${pid}/fd/0
            printf "\033]11;#000000\007" >> /proc/${pid}/fd/0
        fi
    done
}

# Foot
if [ "$(command -v foot)" ] ; then
    # Make color theme switch 'permanent'.
    echo "include=~/.config/foot/themes/${theme}.ini" > ~/.config/foot/theme.ini &
    # We will have to change the terminal colors ourselves.
    update_terminal_colors &
fi

# GNOME (GTK)
if [ "$(command -v gsettings)" ]; then
    gsettings set org.gnome.desktop.interface color-scheme "${gsettings_alt[${theme}]}" &
    gsettings set org.gnome.desktop.interface gtk-theme "${gtk_theme[${theme}]}" &
fi

# Kitty
if [ "$(command -v kitty)" ]; then
    kitten themes --reload-in all --config-file-name theme.conf "${theme}" &
fi

# Sway
if [ "$(command -v swaybg)" ]; then
    bg_path="${BG_DIR}/${wallpaper[${theme}]}"
    /run/current-system/sw/bin/cp "${bg_path}" "${STATE_DIR}/bg" && swaymsg reload &
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


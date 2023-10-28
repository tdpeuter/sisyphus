#!/usr/bin/env bash
# 
# ~/.config/sway/autostart.sh
# List of applications to autostart
#

function execute () {
    setsid --fork $SHELL -c "${1}" &> /dev/null
}

# Idle script
execute "~/.scripts/idle.sh"

# Gamma and brightness
execute "clight"

# Notification manager
execute "dunst -verbosity crit"

# Fix [Slow launch for some GTK apps](https://github.com/swaywm/sway/issues/5732)
dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

# Fix JetBrain IDE's showing properly
wmname LG3


sleep 3
# --- Everything that requires tray to be active ---

# Nextcloud client
execute "nextcloud --background"

# Activity watch server & client
execute "aw-qt"


img=/tmp/i3lock.png
icon=~/.config/i3/scripts/lock-icon-large.png

scrot -z -o $img
convert \( $img -scale 20% -scale 500% -brightness-contrast -30x-30 \) $icon -gravity Center -geometry +0-125 -composite $img


i3lock -i $img -f #-no-unlock-indicator

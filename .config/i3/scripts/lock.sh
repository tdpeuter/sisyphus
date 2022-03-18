img=/tmp/i3lock.png

scrot -z -o $img
convert $img -scale 20% -scale 500% -gamma 0.8 $img

i3lock -i $img #-u

#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]] ; then 
	sway &
fi

bash .config/genavbackgroundcolor.sh
bash .config/updatecolors.sh


# 
# ~/.zprofile
#

# Autostart sway on login
if [[ -z ${DISPLAY} && ${TTY} = /dev/tty1 ]] ; then
    exec sway
fi


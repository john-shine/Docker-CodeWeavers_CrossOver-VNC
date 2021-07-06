#!/bin/sh
#
if [[ -f ${HOME}/.vnc/passwd ]]; then
    echo "${vnc_password}" | vncpasswd -f > ${HOME}/.vnc/passwd
fi

[ -z "${DISPLAY}" ] || /usr/bin/vncserver -kill ${DISPLAY}
sudo rm -f /tmp/.X*-lock /tmp/.X11-unix/X*

sleep 3

if [ -z $vnv_password ]; then
    /usr/bin/vncserver -geometry 1920x1080 -fg -localhost no -SecurityTypes None,TLSNone
else
    /usr/bin/vncserver -geometry 1920x1080 -fg -localhost no
fi

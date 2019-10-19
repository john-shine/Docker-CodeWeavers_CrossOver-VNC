#!/bin/sh

if [[ -f ${HOME}/.vnc/passwd ]]; then
    echo "${vnc_password}" | vncpasswd -f > ${HOME}/.vnc/passwd
fi

[ -z "${DISPLAY}" ] || /usr/bin/vncserver -kill ${DISPLAY}; sudo rm -f /tmp/.X*-lock; sudo rm -rf /tmp/.X11-unix/*; sleep 2
/usr/bin/vncserver -geometry 1024x800 -fg

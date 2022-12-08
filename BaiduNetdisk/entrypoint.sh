#!/bin/sh

if [ -f "${HOME}/baidunetdiskdownload/.vnc/passwd.txt" ]; then
    vnc_password=$(cat "${HOME}/baidunetdiskdownload/.vnc/passwd.txt")
fi

if [ -d "${HOME}/baidunetdiskdownload/.reset" ]; then
    rm -rf ${HOME}/baidunetdisk/*
    rm -rf "${HOME}/baidunetdiskdownload/.reset/"
fi

echo "${vnc_password}" | vncpasswd -f > ${HOME}/.vnc/passwd

[ -z "${DISPLAY}" ] || /usr/bin/vncserver -kill ${DISPLAY}
sudo rm -f /tmp/.X*-lock /tmp/.X11-unix/X*

sleep 3

if [ -z $vnc_password ]; then
    /usr/bin/vncserver -geometry 1920x1080 -localhost no -fg -SecurityTypes None,TLSNone
else
    /usr/bin/vncserver -geometry 1920x1080 -localhost no -fg
fi

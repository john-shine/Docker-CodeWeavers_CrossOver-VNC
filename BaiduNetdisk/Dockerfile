# Using Ubuntu 18.04 base image and VNC

FROM ubuntu:18.04
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="baidu"
ENV UID=1000
ENV GID=0
ENV HOME=/home/${USER}
ARG vnc_password=""
EXPOSE 5901 6080

ADD xstartup ${HOME}/.vnc/

RUN useradd -g ${GID} -u ${UID} -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends apt-utils sudo git curl wget ca-certificates python python-numpy fluxbox && \
    apt-get install -y --no-install-recommends tigervnc-standalone-server tigervnc-common && \
    /bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    wget https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz -O /tmp/noVNC.tar.gz && \
    tar -zxvf /tmp/noVNC.tar.gz -C /opt && \
    git clone https://github.com/novnc/websockify /opt/noVNC-1.1.0/utils/websockify && \
    rm -rf /opt/noVNC-1.1.0/utils/websockify/.git /tmp/noVNC.tar.gz && \
    mv /opt/noVNC-1.1.0/vnc_lite.html /opt/noVNC-1.1.0/index.html && \
    sed -i 's/<title>noVNC<\/title>/<title>百度云网盘客户端<\/title>/g' /opt/noVNC-1.1.0/index.html && \
    apt-get remove -y git-man git && \
    apt-get clean

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority /var/log/baidunetdisk.log

RUN chown -R ${UID}:${GID} ${HOME}
RUN chown ${UID}:${GID} /var/log/baidunetdisk.log
RUN chmod 755 ${HOME}/.vnc/xstartup
RUN chmod 600 ${HOME}/.vnc/passwd

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get install -y --no-install-recommends dbus-x11 fcitx-module-dbus fcitx-ui-classic fcitx-googlepinyin locales && \
    apt-get install -y --no-install-recommends libxtst6 libgtk-3-0 libnotify4 libnss3 libxss1 libatspi2.0-0 libappindicator3-1 libsecret-1-0 libgbm1 libasound2 fonts-wqy-microhei xdg-utils desktop-file-utils && \
    last_version=$(curl -s "http://pan.baidu.com/disk/cmsdata?do=client"|grep -i -o "http:[0-9a-z/\\\.\_\-]*\.deb"|sed 's/\\//g') && \
    wget ${last_version} -O /tmp/baidunetdisk_linux.deb && \
    dpkg -i /tmp/baidunetdisk_linux.deb && \
    apt-get clean && rm -f /tmp/baidunetdisk_linux.deb

RUN locale-gen zh_CN.UTF-8

ENV LC_ALL "zh_CN.UTF-8"


USER ${USER}
WORKDIR ${HOME}


RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bashrc

RUN mkdir -p ${HOME}/.fluxbox
RUN /bin/echo -e "session.screen0.toolbar.placement: TopCenter" >> ${HOME}/.fluxbox/init
RUN /bin/echo -e "session.screen0.workspaces:     1 ">> ${HOME}/.fluxbox/init

# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nfbsetroot -solid gray"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fluxbox &"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e 'export GTK_IM_MODULE=fcitx' >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e 'export QT_IM_MODULE=fcitx' >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e 'export XMODIFIERS="@im=fcitx"' >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "sleep 3"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fcitx"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "/opt/noVNC-1.1.0/utils/launch.sh --listen 6080 --vnc 127.0.0.1:5901 &"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "sudo mkdir -p /home/baidu/baidunetdiskdownload/"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "sudo chmod -R a=rwx /home/baidu/baidunetdiskdownload/"  >> ${HOME}/.vnc/xstartup

RUN /bin/echo -e "while true; do" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    /opt/baidunetdisk/baidunetdisk --no-sandbox >> /var/log/baidunetdisk.log 2>&1" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "done" >> ${HOME}/.vnc/xstartup

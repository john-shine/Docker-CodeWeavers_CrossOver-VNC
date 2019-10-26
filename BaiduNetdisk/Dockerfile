# Using CentOS 7 base image and VNC

FROM centos:7
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="baidu"
ENV UID=100
ENV GID=0
ENV HOME=/home/${USER}
ARG vnc_password=""
EXPOSE 5901 6080

ADD xstartup ${HOME}/.vnc/

RUN /bin/dbus-uuidgen --ensure
RUN useradd -g ${GID} -u ${UID} -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN yum check-update -y ; \
    yum --enablerepo=extras install -y --setopt=tsflags=nodocs tigervnc-server epel-release && \
    yum install -y --setopt=tsflags=nodocs fluxbox git sudo which wget && \
    /bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    wget https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz -O /tmp/noVNC.tar.gz && \
    tar -zxvf /tmp/noVNC.tar.gz -C /opt && \
    git clone https://github.com/novnc/websockify /opt/noVNC-1.1.0/utils/websockify && \
    rm -rf /opt/noVNC-1.1.0/utils/websockify/.git /tmp/noVNC.tar.gz && \
    mv /opt/noVNC-1.1.0/vnc_lite.html /opt/noVNC-1.1.0/index.html && \
    sed -i 's/<title>noVNC<\/title>/<title>百度云网盘客户端<\/title>/g' /opt/noVNC-1.1.0/index.html && \
    yum remove -y git && \
    yum clean all && rm -rf /var/cache/yum/*

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority /var/log/baidunetdisk.log

RUN chown -R ${UID}:${GID} ${HOME} && \
    chown ${UID}:${GID} /var/log/baidunetdisk.log && \
    chmod 755 ${HOME}/.vnc/xstartup && \
    chmod 600 ${HOME}/.vnc/passwd

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN yum install -y --setopt=tsflags=nodocs gtk3 kde-l10n-Chinese libXScrnSaver alsa-lib google-noto-sans-simplified-chinese-fonts && \
    wget http://issuecdn.baidupcs.com/issue/netdisk/LinuxGuanjia/2.0.2/baidunetdisk_linux_2.0.2.rpm -O /tmp/baidunetdisk_linux.rpm && \
    rpm -ivh /tmp/baidunetdisk_linux.rpm && \
    yum clean all && rm -rf /var/cache/yum/* && \
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

ENV LC_ALL "zh_CN.UTF-8"  
ADD lib/libstdc++.so.6.0.25 /lib64/
RUN ln -snf /lib64/libstdc++.so.6.0.25 /lib64/libstdc++.so.6

USER ${USER}
WORKDIR ${HOME}

RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bashrc

# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fluxbox &"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "/opt/noVNC-1.1.0/utils/launch.sh --listen 6080 --vnc 127.0.0.1:5901 &"  >> ${HOME}/.vnc/xstartup

RUN /bin/echo -e "while true; do" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    /opt/baidunetdisk/baidunetdisk >> /var/log/baidunetdisk.log 2>&1" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "done" >> ${HOME}/.vnc/xstartup

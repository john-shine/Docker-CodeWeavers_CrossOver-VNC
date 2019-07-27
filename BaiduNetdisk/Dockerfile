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
EXPOSE 5901

ADD xstartup ${HOME}/.vnc/

RUN /bin/dbus-uuidgen --ensure
RUN useradd -g ${GID} -u ${UID} -r -d ${HOME} -s /bin/bash ${USER}
RUN echo "root:root" | chpasswd
# set password of ${USER} to ${USER}
RUN echo "${USER}:${USER}" | chpasswd

RUN yum check-update -y ; \
    yum install -y --setopt=tsflags=nodocs tigervnc-server xorg-x11-server-utils xorg-x11-server-Xvfb xorg-x11-fonts-* motif xterm && \
    yum install -y --setopt=tsflags=nodocs sudo which wget file zenity && \
    yum install -y --setopt=tsflags=nodocs freetype.i686 freetype.x86_64 glibc.i686 glibc.x86_64 libICE.i686 libICE.x86_64 libSM.i686 libSM.x86_64 libX11.i686 libX11.x86_64 libXext.i686 libXext.x86_64 libgcc.i686 libgcc.x86_64 libpng.i686 libpng.x86_64 nss-mdns.i686 nss-mdns.x86_64 pygtk2 zlib.i686 zlib.x86_64 && \
    /bin/echo -e "\n${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    yum clean all && rm -rf /var/cache/yum/*

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority

RUN chown -R ${UID}:${GID} ${HOME} && \
    chmod 775 ${HOME}/.vnc/xstartup && \
    chmod 600 ${HOME}/.vnc/passwd

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN yum install -y --setopt=tsflags=nodocs kde-l10n-Chinese libXScrnSaver alsa-lib google-noto-sans-simplified-chinese-fonts && \
    wget http://issuecdn.baidupcs.com/issue/netdisk/LinuxGuanjia/baidunetdisk_linux_2.0.1.rpm -O /tmp/baidunetdisk_linux.rpm && \
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

RUN /bin/echo -e "baidunetdisk >> ~/.baidunetdisk.log" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "tail -f /dev/null" >> ${HOME}/.vnc/xstartup


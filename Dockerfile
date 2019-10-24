# Using CentOS 7 base image and VNC

FROM centos:7
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

USER root

ENV DISPLAY=":1"
ENV USER="crossover"
ENV UID=100
ENV GID=0
ENV HOME=/home/${USER}
ENV INSTALLDIR=/opt/cxoffice
ARG vnc_password=""
EXPOSE 5901 6080

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
    yum install -y git && \
    git clone -b v0.9.6 https://github.com/wolfcw/libfaketime.git /tmp/libfaketime && \
    yum groupinstall -y "Development Tools" && \
    yum install -y glibc-devel.i686 && \
    cd /tmp/libfaketime && \
    export CFLAGS="-m32" && \
    export LDFLAGS="-m32" && \
    make && make install && \
    wget https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz -O /tmp/noVNC.tar.gz && \
    tar -zxvf /tmp/noVNC.tar.gz -C /opt && \
    git clone https://github.com/novnc/websockify /opt/noVNC-1.1.0/utils/websockify && \
    mv /opt/noVNC-1.1.0/vnc_lite.html /opt/noVNC-1.1.0/index.html && \
    yum remove -y git glibc-devel.i686 && \
    yum groupremove -y "Development Tools" && \
    rm -rf /tmp/libfaketime && rm -f /tmp/noVNC.tar.gz && \
    yum clean all && rm -rf /var/cache/yum/*

RUN /bin/echo "@`date \"+%F %T\"`" > /etc/faketimerc

RUN touch ${HOME}/.vnc/passwd ${HOME}/.Xauthority

RUN chown -R ${UID}:${GID} ${HOME} && \
    chmod 775 ${HOME}/.vnc/xstartup && \
    chmod 600 ${HOME}/.vnc/passwd && \
    mkdir -p ${INSTALLDIR} && \
    chown -R ${UID}:${GID} ${INSTALLDIR}

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER ${USER}

RUN /bin/echo -e 'alias ll="ls -last"' >> ${HOME}/.bashrc
# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "/opt/noVNC-1.1.0/utils/launch.sh --listen 6080 --vnc 127.0.0.1:5901 &"  >> ${HOME}/.vnc/xstartup
RUN cp ${HOME}/.vnc/xstartup ${HOME}/.vnc/xstartup_after
RUN /bin/echo -e "${INSTALLDIR}/bin/crossover" >> ${HOME}/.vnc/xstartup_after

# install crossover
RUN /bin/echo -e "wget --no-check-certificate http://crossover.codeweavers.com/redirect/crossover.bin -O /tmp/install-crossover.bin && chmod +x /tmp/install-crossover.bin && /tmp/install-crossover.bin --i-agree-to-all-licenses --destination ${INSTALLDIR} --noreadme --noprompt --nooptions" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "zenity --info --text=\"Crossover Software install complete.\"" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "rm -f /tmp/install-crossover.bin" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "mv ${HOME}/.vnc/xstartup_after ${HOME}/.vnc/xstartup" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "rm -f ${HOME}/.vnc/*.log ${HOME}/.vnc/*.pid" >> ${HOME}/.vnc/xstartup


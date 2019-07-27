FROM johnshine/crossover-vnc:latest
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

ENV BOTTLE="Thunder"
EXPOSE 5901

USER root

ADD xstartup ${HOME}/.vnc/
RUN chmod 775 ${HOME}/.vnc/xstartup

RUN yum check-update -y ; \
    yum install -y --setopt=tsflags=nodocs libv4l.i686 fontconfig.i686 libXcomposite.i686 libXinerama.i686 libgphoto2.i686 libxml2.i686 libxslt.i686 openldap.i686 sane-backends-libs.i686 mesa-dri-drivers.i686 isdn4k-utils.i686 gsm.i686 gstreamer-plugins-base.i686 lcms2.i686 mesa-libOSMesa.i686 libtiff.i686 gnutls.i686 glibc.i686 zlib.i686 freetype.i686 libgcc.i686 libXext.i686 alsa-lib.i686 cups-libs.i686 libXcursor.i686 libXi.i686 libXrandr.i686 libXrender.i686 libXxf86vm.i686 openssl.i686 libpng.i686 libX11.i686 mesa-libGL.i686 freetype.x86_64 glibc.x86_64 libICE.i686 libICE.x86_64 libSM.i686 libSM.x86_64 libX11.x86_64 libXext.x86_64 libgcc.x86_64 libpng.x86_64 nss-mdns.i686 nss-mdns.x86_64 pygtk2 zlib.x86_64 wqy-microhei-fonts && \
    yum install -y --setopt=tsflags=nodocs kde-l10n-Chinese && \
    yum reinstall -y glibc-common && \
    yum clean all && rm -rf /var/cache/yum/*

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL "zh_CN.UTF-8"  

RUN ln -s /usr/lib/libtiff.so.5.2.0 /usr/lib/libtiff.so.4 && \
    ln -s /usr/lib/libOSMesa.so.8.0.0 /usr/lib/libOSMesa.so.6

WORKDIR ${HOME}

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

USER ${USER}

COPY installers /tmp/installers

# Always run the WM last!
RUN /bin/echo -e "export DISPLAY=${DISPLAY}"  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup
RUN /usr/bin/cp ${HOME}/.vnc/xstartup ${HOME}/.vnc/xstartup_after

RUN /bin/echo -e "if [[ ! -f \"${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf\" ]]; then" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    ${INSTALLDIR}/bin/cxbottle --create --bottle \"${BOTTLE}\" --description \"迅雷容器\" --template \"winxp\"" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    sed -i -e 's/;;\"AllowUntrusted\" = \"\"/\"AllowUntrusted\" = \"1\"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    [[ -d /mnt/drive_d ]] && ln -snf /mnt/drive_d \"${HOME}/.cxoffice/${BOTTLE}/dosdevices/d:\""  >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    cp /tmp/installers/dll/* \"${HOME}/.cxoffice/${BOTTLE}/drive_c/windows/system32/\"" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    tar -zxf /tmp/installers/Thunder\ Network.tar.gz --directory=\"${HOME}/.cxoffice/${BOTTLE}/drive_c/Program Files/\"" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "    mv ${HOME}/.vnc/xstartup_after ${HOME}/.vnc/xstartup" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "fi" >> ${HOME}/.vnc/xstartup

RUN /bin/echo -e "[[ -d /mnt/drive_d ]] && sudo chown -R ${UID}:${GID} /mnt/drive_d" | tee -a ${HOME}/.vnc/xstartup ${HOME}/.vnc/xstartup_after
RUN /bin/echo -e "alias wine=\"LD_PRELOAD=/usr/local/lib/faketime/libfaketime.so.1 ${INSTALLDIR}/bin/wine\"" | tee -a ${HOME}/.vnc/xstartup ${HOME}/.vnc/xstartup_after
RUN /bin/echo -e "wine --bottle ${BOTTLE} \"c:\\\\\\\\Program Files\\\\\\\\Thunder Network\\\\\\\\Program\\\\\\\\Thunder.exe\"" | tee -a ${HOME}/.vnc/xstartup ${HOME}/.vnc/xstartup_after
RUN /bin/echo -e "tail -f /dev/null" >> ${HOME}/.vnc/xstartup


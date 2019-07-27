FROM johnshine/crossover-vnc:latest
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

ENV BOTTLE="Lyx"
EXPOSE 5901

USER root
RUN yum check-update -y ; \
    yum install -y --setopt=tsflags=nodocs libncurses.so.5 && \
    yum clean all && rm -rf /var/cache/yum/*


WORKDIR ${HOME}

USER ${USER}

RUN ${INSTALLDIR}/bin/cxbottle --create --bottle "${BOTTLE}" --template "winxp"
RUN sed -i -e 's/;;"AllowUntrusted" = ""/"AllowUntrusted" = "1"/' ${HOME}/.cxoffice/${BOTTLE}/cxbottle.conf

RUN wget https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/BaiduNetdisk/fonts/simsun.ttc -O ~/.cxoffice/${BOTTLE}/drive_c/windows/Fonts/simsun.ttc
RUN wget https://raw.githubusercontent.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/master/Lyx/installers/Lyx.tar.xz -O /tmp/Lyx.tar.xz && tar -Jxf /tmp/Lyx.tar.xz -C ${HOME}/.cxoffice/${BOTTLE}/drive_c/Program\ Files/ && rm -f /tmp/Lyx.tar.xz

RUN ${INSTALLDIR}/bin/wine --bottle ${BOTTLE} --wait-children --wl-app 'reboot.exe'
ADD xstartup ${HOME}/.vnc/
RUN sudo chown ${USER}:root ${HOME}/.vnc/xstartup

# Xresource settings
RUN /bin/echo -e "export DISPLAY=${DISPLAY}\n[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup

RUN /bin/echo -e "${INSTALLDIR}/bin/wine --bottle ${BOTTLE} \"c:\\\\\\\\Program Files\\\\\\\\Lyx\\\\\\\\LuYouXia.exe\"" >> ${HOME}/.vnc/xstartup
RUN /bin/echo -e "tail -f /dev/null" >> ${HOME}/.vnc/xstartup
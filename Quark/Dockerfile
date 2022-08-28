FROM johnshine/crossover-vnc:latest
MAINTAINER john.shine <mr.john.shine@gmail.com>
LABEL io.openshift.expose-services="5901:tcp"

ENV BOTTLE="quark"

USER root

ENV DISPLAY=":1"
ENV USER="quark"
ENV UID=1000
ENV GID=0
ENV HOME=/home/${USER}
ARG vnc_password=""
EXPOSE 5901 6080

RUN yum check-update -y ; \
    yum install -y --setopt=tsflags=nodocs libncurses.so.5 && \
    yum clean all && rm -rf /var/cache/yum/*


WORKDIR ${HOME}

USER ${USER}

ADD xstartup ${HOME}/.vnc/
RUN sudo chown ${USER}:root ${HOME}/.vnc/xstartup

# Xresource settings
RUN /bin/echo -e "export DISPLAY=${DISPLAY}\n[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources\nxsetroot -solid grey"  >> ${HOME}/.vnc/xstartup

${HOME}/.vnc/xstartup
RUN /bin/echo -e "tail -f /dev/null" >> ${HOME}/.vnc/xstartup

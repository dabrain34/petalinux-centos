FROM docker.io/library/centos:7
MAINTAINER scerveau
LABEL Version 0.1
ARG USER_NAME=scerveau
ARG DOCKER_BIN=scerveau

ENV container $DOCKER_BIN

# NOTE: Systemd needs /sys/fs/cgroup directoriy to be mounted from host in
# read-only mode. (Required).
# VOLUME [ "/sys/fs/cgroup" ]

# Systemd needs /run directory to be a mountpoint, otherwise it will try
# to mount tmpfs here (and will fail).  (Required).
VOLUME [ "/run" ]

RUN yum -y update                      && \
    yum -y install openssh xterm rsync && \
    yum clean all

RUN yum -y install xinetd gcc git zlib-devel ncurses-devel openssl-devel \
      libselinux1 bc unzip minicom screen net-tools gnupg diffstat \
      xorg-x11-server-Xvfb chrpath socat autoconf file \
      libtool bzip2 patch gcc-c++ texinfo automake glib2-devel \
      dos2unix iproute gawk gnutls-devel net-tools tftp-server flex bison \
      libstdc++.i686 glibc.i686 libgcc.i686 libgomp.i686 ncurses-libs.i686 \
      zlib.i686 fontconfig.i686 libXext.i686 libXrender.i686 glib2.i686 \
      libpng12.i686 libSM.i686 usbutils expect wget sudo which ; \
      yum clean all

RUN wget http://mirror.centos.org/centos/7/os/x86_64/Packages/libpng12-1.2.50-10.el7.x86_64.rpm
RUN rpm -ivh libpng12-1.2.50-10.el7.x86_64.rpm

RUN sed -ie 's/disable.*= yes/disable = no/' /etc/xinetd.d/tftp

RUN echo "%sudo ALL=(ALL:ALL) ALL" >> /etc/sudoers
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set locale
#RUN localectl set-locale en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

# Set up a user
RUN useradd --uid 1000 --groups wheel --system --create-home scerveau
RUN echo "$USER_NAME:$USER_NAME" | chpasswd
WORKDIR /home/$USER_NAME

RUN chmod +w /opt && chown -R $USER_NAME:$USER_NAME /opt

CMD /bin/sh


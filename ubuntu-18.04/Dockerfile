FROM docker.io/library/ubuntu:18.04

ENV NAME=ubuntu-toolbox VERSION=18.04
LABEL com.github.containers.toolbox="true" \
      com.github.debarshiray.toolbox="true" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Base image for creating $NAME $VERSION toolbox containers"

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install \
    bash-completion \
    git \
    keyutils \
    libcap2-bin \
    lsof \
    man-db \
    mlocate \
    mtr \
    rsync \
    sudo \
    tcpdump \
    time \
    traceroute \
    tree \
    unzip \
    wget \
    zip && \
    apt-get clean

RUN sed -i -e 's/ ALL$/ NOPASSWD:ALL/' /etc/sudoers

RUN echo VARIANT_ID=container >> /etc/os-release
RUN touch /etc/localtime

CMD /bin/sh

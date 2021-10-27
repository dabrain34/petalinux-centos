#!/bin/bash

USER_NAME=$1
DOCKER_BIN=$2
VERSION=$(date '+%Y-%m-%d')

DEFAULT_USER_NAME=`whoami`
DEFAULT_DOCKER_BIN="docker"

if [ -z $USER_NAME ]; then
echo "Please specify a user name...(default $DEFAULT_USER_NAME)"
read USER_NAME
if [ -z $USER_NAME ]; then
USER_NAME=$DEFAULT_USER_NAME
fi
fi

if [ -z $DOCKER_BIN ]; then
echo "Please specify a docker bin name...(default $DEFAULT_DOCKER_BIN)"
read DOCKER_BIN
if [ -z $DOCKER_BIN ]; then
DOCKER_BIN=$DEFAULT_DOCKER_BIN
fi
fi

set -x
TAG=$USER_NAME-$VERSION
echo $TAG

$DOCKER_BIN build -t centos-petalinux:$TAG --build-arg USER_NAME="$USER_NAME" --build-arg DOCKER_BIN="$DOCKER_BIN" $(dirname $0)

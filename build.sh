#!/bin/bash

USER_NAME=$1
VERSION=$(date '+%Y-%m-%d')

DEFAULT_USER_NAME=`whoami`


if [ -z $USER_NAME ]; then
echo "Please specify a user name...(default $DEFAULT_USER_NAME)"
read USER_NAME
if [ -z $USER_NAME ]; then
USER_NAME=$DEFAULT_USER_NAME
fi
fi

set -x
TAG=$USER_NAME-$VERSION
echo $TAG

docker build -t centos-petalinux:$TAG --build-arg USER_NAME="$USER_NAME" $(dirname $0)

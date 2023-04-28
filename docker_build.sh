#! /bin/bash

#list of cross-prefix:
# aarch64-linux-gnu-, x86_64-linux-gnu-
#list of DPKG_ARCH:
# arm64, amd64

REPOSITORY="qemnu-static-user-aarch64"
TAG="last"

docker build \
    --pull \
    -t $REPOSITORY:$TAG \
    --build-arg hostuid=$(id -u) \
    --build-arg hostgid=$(id -g) \
    --build-arg USER_NAME=$(id -un) \
    --build-arg CROSS_PREFIX=x86_64-linux-gnu- \
	--build-arg CROSS_DPKG_ARCH=amd64 \
    .

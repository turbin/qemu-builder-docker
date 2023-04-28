#! /bin/bash

#list of cross-prefix:
# aarch64-linux-gnu-, x86_64-linux-gnu-
#list of DPKG_ARCH:
# arm64(aarch64), amd64

WORKSAPCE=$1
ARCH='amd64'
docker run \
    -v $WORKSAPCE/qemu-src:/home/$USER/qemnu_build \
    -it \
    --name qemu-static-user-builder-$ARCH \
    qemnu-static-user-$ARCH:last
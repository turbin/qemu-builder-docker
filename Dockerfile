##################################################
## "build" stage
##################################################

FROM debian:11 AS build

ARG CROSS_PREFIX=
ARG CROSS_DPKG_ARCH=

ARG hostuid=
ARG hostgid=
ARG USER_NAME=

# Install system packages
RUN export DEBIAN_FRONTEND=noninteractive \
	&& { [ -z "${CROSS_DPKG_ARCH?}" ] || dpkg --add-architecture "${CROSS_DPKG_ARCH:?}"; } \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		ca-certificates \
		file \
		git \
		libcap2-bin \
		make \
		meson \
		ninja-build \
		pkgconf \
		python3 \
		${CROSS_DPKG_ARCH:+crossbuild-essential-"${CROSS_DPKG_ARCH:?}"} \
		libglib2.0-dev"${CROSS_DPKG_ARCH:+:"${CROSS_DPKG_ARCH:?}"}" \
	&& rm -rf /var/lib/apt/lists/*

# Build QEMU
# RUN mkdir /tmp/qemu/
# WORKDIR /tmp/qemu/
# RUN mkdir /tmp/qemu/build/
# WORKDIR /tmp/qemu/build/


RUN \
    groupadd --gid $hostgid --force $USER_NAME && \
    useradd --gid $hostgid --uid $hostuid --non-unique $USER_NAME

#RUN touch /etc/sudoers.d/$USER_NAME
#RUN echo "$USER_NAME ALL=NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME


VOLUME /home/$USER_NAME/qemnu_build
USER $USER_NAME
WORKDIR /home/$USER_NAME/qemnu_build

# RUN ../configure \
# 		--static --cross-prefix="${CROSS_PREFIX?}" \
# 		--enable-user --enable-werror --enable-stack-protector \
# 		--disable-system --disable-modules --disable-tools --disable-guest-agent --disable-debug-info --disable-docs \
# 		--target-list='x86_64-linux-user aarch64-linux-user arm-linux-user ppc64le-linux-user s390x-linux-user riscv64-linux-user'
# RUN make -j"$(nproc)"


FROM ubuntu:16.04

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
  file \
  curl \
  ca-certificates \
  python \
  unzip \
  expect \
  openjdk-9-jre \
  libstdc++6:i386 \
  gcc \
  libc6-dev && \
   curl https://sh.rustup.rs -sSf | sh -s -- -y && \
   ${HOME}/.cargo/bin/rustup toolchain install 1.17.0 && \
   ${HOME}/.cargo/bin/rustup target list | grep android | xargs ${HOME}/.cargo/bin/rustup target install && \
   ${HOME}/.cargo/bin/rustup target list | grep apple | xargs ${HOME}/.cargo/bin/rustup target install

WORKDIR /android/

COPY install-ndk.sh /android/
RUN sh /android/install-ndk.sh

ENV PATH=$PATH:/android/ndk-arm/bin:/android/sdk/tools:/android/sdk/platform-tools

COPY install-sdk.sh accept-licenses.sh /android/
RUN sh /android/install-sdk.sh

ENV PATH=$PATH:${HOME}/.cargo/bin \
    CARGO_TARGET_ARM_LINUX_ANDROIDEABI_LINKER=arm-linux-androideabi-gcc \
    ANDROID_EMULATOR_FORCE_32BIT=1 \
    HOME=/tmp
RUN chmod 755 /android/sdk/tools/*

RUN cp -r /root/.android /tmp
RUN chmod 777 -R /tmp/.android

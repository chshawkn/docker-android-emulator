FROM ubuntu:16.04

ENV PATH=$PATH:${HOME}/.cargo/bin
RUN dpkg --add-architecture amd64 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
  file \
  curl \
  ca-certificates \
  python \
  unzip \
  expect \
  openjdk-9-jre \
  libstdc++6:amd64 \
  gcc \
  libc6-dev && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    rustup toolchain install 1.17.0 && \
    rustup target list | grep android | xargs rustup target install && \
    rustup target list | grep apple | xargs rustup target install

WORKDIR /android/

COPY install-ndk.sh /android/
RUN sh /android/install-ndk.sh

ENV PATH=$PATH:/android/ndk-arm64/bin:/android/sdk/tools:/android/sdk/platform-tools

COPY install-sdk.sh accept-licenses.sh /android/
RUN sh /android/install-sdk.sh

ENV CARGO_TARGET_ARM_LINUX_ANDROIDEABI_LINKER=aarch64-linux-android-gcc \
    ANDROID_EMULATOR_FORCE_32BIT=0 \
    HOME=/tmp
RUN chmod 755 /android/sdk/tools/*

RUN cp -r /root/.android /tmp
RUN chmod 777 -R /tmp/.android

# docker-android-emulator

android-emulator for CI


debug:

    docker pull chshawkn/android-emulator:${1}-gcc

    # cannot find name for user ID xxx: --user `id -u`:`id -g` \
    # --volume $HOME/.cargo:/cargo \
    # --env CARGO_HOME=/cargo \
    # --volume `rustc --print sysroot`:/rust:ro \
    docker run \
          --rm \
          --volume `pwd`:/checkout:ro \
          --volume `pwd`/target:/checkout/target \
          --env CARGO_TARGET_DIR=/checkout/target \
          --workdir /checkout \
          --privileged \
          --interactive \
          --tty \
          chshawkn/android-emulator:aarch64-linux-android-gcc \
          /bin/bash

    docker run \
          --rm \
          --volume `pwd`:/checkout:ro \
          --volume `pwd`/target:/checkout/target \
          --env CARGO_TARGET_DIR=/checkout/target \
          --workdir /checkout \
          --privileged \
          --interactive \
          --tty \
          libc \
          /bin/bash

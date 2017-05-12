# Small script to run tests for a target (or all targets) inside all the
# respective docker images.

set -ex

run() {
    echo $1
    #docker build -t chshawkn/android-emulator:$1 $1
    mkdir -p target
    docker run \
      --rm \
      --volume `pwd`:/checkout:ro \
      --volume `pwd`/target:/checkout/target \
      --env CARGO_TARGET_DIR=/checkout/target \
      --workdir /checkout \
      --privileged \
      --interactive \
      --tty \
      chshawkn/android-emulator:$1 \
      ci/run.sh $1
}

if [ -z "$1" ]; then
  for d in `ls ci/docker/`; do
    run $d
  done
else
  run $1
fi

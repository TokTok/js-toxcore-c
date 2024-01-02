#!/bin/sh

set -eux

docker run --rm -v "$PWD:/work/js-toxcore-c" --tmpfs /work/js-toxcore-c/node_modules:exec -it toxchat/js-toxcore-c

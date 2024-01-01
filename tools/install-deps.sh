#!/bin/sh

set -eux

# install toxcore
if ! [ -d c-toxcore ]; then
  git clone --depth=1 --recurse-submodules --shallow-submodules --branch=master https://github.com/TokTok/c-toxcore
fi
cd c-toxcore
git rev-parse HEAD >c-toxcore.sha
if ! ([ -f "$CACHE_DIR/c-toxcore.sha" ] && diff "$CACHE_DIR/c-toxcore.sha" c-toxcore.sha); then
  cmake -B_build -H. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/cache/usr"
  make -C_build -j"$(nproc)"
  make -C_build install
  mv c-toxcore.sha "$CACHE_DIR/c-toxcore.sha"
fi
cd ..
rm -rf c-toxcore

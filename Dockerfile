FROM ubuntu:22.04

RUN apt-get update && \
 DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
 ca-certificates \
 build-essential \
 cmake \
 git \
 libopus-dev \
 libsodium-dev \
 libvpx-dev \
 ninja-build \
 nodejs \
 npm \
 pkg-config \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /work/c-toxcore
RUN git clone --depth=1 --recurse-submodules --shallow-submodules --branch=master https://github.com/TokTok/c-toxcore.git /work/c-toxcore
RUN cmake -B_build -H. -GNinja
RUN cmake --build _build --target install

WORKDIR /work/js-toxcore-c
COPY . /work/js-toxcore-c/
ENV LD_LIBRARY_PATH=/usr/local/lib
RUN ls -l /usr/local/lib/libtoxcore.so
RUN npm install
RUN npm run doc
RUN npm run test
RUN npm run coverage
RUN npm run format
#COPY . /work/js-toxcore-c.orig/
#RUN diff -ru /work/js-toxcore-c /work/js-toxcore-c.orig

FROM alpine:3.13.0

RUN ["apk", "add", "--no-cache", \
 "cmake", \
 "diffutils", \
 "g++", \
 "gcc", \
 "git", \
 "libsodium-dev", \
 "libvpx-dev", \
 "linux-headers", \
 "make", \
 "musl-dev", \
 "npm", \
 "opus-dev", \
 "pkgconfig", \
 "python3", \
 "samurai"]

WORKDIR /work/c-toxcore
RUN ["git", "clone", "--depth=1", \
 "--recurse-submodules", "--shallow-submodules", \
 "--branch=master", \
 "https://github.com/TokTok/c-toxcore.git", "/work/c-toxcore"]
RUN ["cmake", "-B_build", "-H.", "-GNinja", "-DBOOTSTRAP_DAEMON=OFF"]
RUN ["cmake", "--build", "_build", "--target", "install"]

WORKDIR /work/js-toxcore-c
COPY . /work/js-toxcore-c/
ENV LD_LIBRARY_PATH=/usr/local/lib64
RUN ["ls", "-lh", "/usr/local/lib64/libtoxcore.so.2"]
RUN ["npm", "install"]
RUN ["npm", "run", "doc"]
RUN ["npm", "run", "test"]
RUN ["npm", "run", "coverage"]
RUN ["npm", "run", "format"]
COPY . /work/js-toxcore-c.orig/
RUN rm -rf \
 /work/js-toxcore-c*/.nyc_output \
 /work/js-toxcore-c*/doc \
 /work/js-toxcore-c*/node_modules \
 /work/js-toxcore-c*/coverage.lcov \
 /work/js-toxcore-c*/package-lock.json
RUN diff -ru /work/js-toxcore-c.orig /work/js-toxcore-c

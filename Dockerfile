FROM alpine:3.3

# Thanks to https://github.com/mhart/alpine-node/blob/master/Dockerfile
ENV VERSION=v6.2.1 NPM_VERSION=3

ENV CONFIG_FLAGS="--without-npm" RM_DIRS=/usr/include

RUN apk add --no-cache docker py-pip curl make gcc g++ python linux-headers paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz | tar -xz && \
  cd /node-${VERSION} && \
  export GYP_DEFINES="linux_use_gold_flags=0" && \
  ./configure --prefix=/usr ${CONFIG_FLAGS} && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make -j${NPROC} -C out mksnapshot BUILDTYPE=Release && \
  paxctl -cm out/Release/mksnapshot && \
  make -j${NPROC} && \
  make install && \
  paxctl -cm /usr/bin/node && \
  cd / && \
  if [ -x /usr/bin/npm ]; then \
    npm install -g npm@${NPM_VERSION} && \
    find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf; \
  fi && \
  pip install awscli && \
  apk del curl make gcc g++ py-pip linux-headers paxctl ${DEL_PKGS} && \
  rm -rf /etc/ssl /node-${VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

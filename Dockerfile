FROM mhart/alpine-node:6.2.1

RUN apk --no-cache add docker py-pip && \
  pip install awscli && \
  apk --purge -v del py-pip

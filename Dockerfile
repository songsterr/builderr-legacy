FROM mhart/alpine-node:6.6.0

RUN apk add --no-cache docker python py-pip git && \
  pip install awscli && \
  apk del py-pip

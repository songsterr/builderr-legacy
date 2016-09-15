# alpine:3.3 comes with docker 1.9.1, which is still required by drone because of API version
FROM alpine:3.3

RUN apk add --no-cache docker python py-pip git && \
  pip install awscli && \
  apk del py-pip

RUN apk add --no-cache nodejs && npm install -g nightwatch

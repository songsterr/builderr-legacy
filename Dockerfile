FROM mhart/alpine-node:6.2.1

RUN apk --no-cache add docker python py-pip && pip install awscli

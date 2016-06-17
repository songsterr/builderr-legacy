FROM mhart/alpine-node:6.2.1

RUN apk --no-cache add docker=1.10.2 python py-pip && pip install awscli

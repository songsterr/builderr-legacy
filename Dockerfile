FROM mhart/alpine-node:6.9.1

RUN apk add --no-cache --update docker python py-pip git curl ca-certificates alpine-sdk && \
  pip install awscli && \
  apk del py-pip

# Install kubectl
# Note: Latest version may be found on:
# https://aur.archlinux.org/packages/kubectl-bin/
ADD https://storage.googleapis.com/kubernetes-release/release/v1.4.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl && kubectl version --client

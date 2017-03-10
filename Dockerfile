FROM mhart/alpine-node:7.7.2

RUN apk add --no-cache --update docker python ansible py-pip git curl ca-certificates alpine-sdk jq && \
  pip install awscli && \
  npm install -g yarn && \
  apk del py-pip

RUN  mkdir /root/.ssh/ && echo -e 'StrictHostKeyChecking no\n' > /root/.ssh/config && chmod 0600 /root/.ssh/config && \
  touch /root/.ssh/id_songsterr_deploy && chmod 0600 /root/.ssh/id_songsterr_deploy && \
  mkdir /etc/ansible/ && echo -e "[defaults]\nhost_key_checking = False\ncallback_whitelist = profile_tasks\n" > /etc/ansible/ansible.cfg  && chmod 0600 /etc/ansible/ansible.cfg

# Install kubectl
# Note: Latest version may be found on:
# https://aur.archlinux.org/packages/kubectl-bin/
ADD https://storage.googleapis.com/kubernetes-release/release/v1.4.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl && kubectl version --client

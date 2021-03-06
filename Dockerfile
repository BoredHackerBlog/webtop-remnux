# depending on cpu, ram, & internet speed, this may take 40 mins to an hour

FROM ghcr.io/linuxserver/webtop:ubuntu-xfce

RUN sudo add-apt-repository --yes ppa:micahflee/ppa
RUN sudo apt update
RUN sudo apt install torbrowser-launcher -y
RUN sudo apt install thunderbird -y

# copied from remnux docker repo
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y wget gnupg git && \
    wget -nv -O - https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg | apt-key add - && \
    echo deb [arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && \
    apt-get install -y salt-common && \
    git clone https://github.com/REMnux/salt-states.git /srv/salt && \
    salt-call -l info --local state.sls remnux.cloud pillar='{"remnux_user": "remnux"}' && \
    rm -rf /srv && \
    rm -rf /var/cache/salt/* && \
    rm -rf /root/.cache/* && \
    unset DEBIAN_FRONTEND

EXPOSE 3000
VOLUME /config

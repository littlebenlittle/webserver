FROM docker.io/library/debian:11

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    wget

RUN pip3 install --upgrade linode-cli

RUN useradd -m user
COPY heartbeat.sh /home/user/heartbeat.sh

USER user

CMD [ "/home/user/heartbeat.sh" ]

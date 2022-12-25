FROM docker.io/ipfs/kubo

COPY setup.sh /container-init.d/
COPY update.sh /scripts/
COPY restore.sh /scripts/
RUN chmod +x /scripts/*

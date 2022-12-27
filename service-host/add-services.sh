#!/bin/sh

set -e

cd /etc/systemd/system/

podman generate systemd --files --name nginx
podman generate systemd --files --name ipfs

systemctl enable container-nginx.service
systemctl enable container-ipfs.service

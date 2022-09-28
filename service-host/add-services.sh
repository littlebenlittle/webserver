#!/bin/sh

set -e

cd /etc/systemd/system/

podman generate systemd --files --name web

systemctl enable pod-web.service
systemctl enable container-nginx.service
systemctl enable container-ipfs.service

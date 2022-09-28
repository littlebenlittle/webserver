#!/bin/sh

set -e

podman pod create \
    --name web \
    -p 80:80 \
    -p 4001:4001 \
    -p 127.0.0.1:5001:5001 \
    -p 127.0.0.1:8080:8080

podman run -d \
    --pod=web \
    --restart=always \
    --name=nginx \
    --cpus='0.10' \
    --memory='10m' \
    --log-opt='max-size=10m' \
    localhost/nginx

podman run -d \
    --pod web \
    --restart always \
    --name ipfs \
    -v ipfs-data:/data/ipfs \
    --cpus='0.25' \
    --memory='490m' \
    --log-opt='max-size=10m' \
    localhost/ipfs

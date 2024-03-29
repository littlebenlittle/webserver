#!/bin/sh

podman pod ls | grep web >/dev/null || podman pod create \
    --name web \
    -p 80:80 \
    -p 4001:4001 \
    -p 127.0.0.1:5001:5001 \
    -p 127.0.0.1:8080:8080

case "$1" in
    'nginx')
        podman stop nginx && podman rm nginx
        podman run -d \
            --pod web \
            --restart=always \
            --name nginx \
            --cpus='0.10' \
            --memory='10m' \
            nginx
    ;;
    'ipfs')
        podman stop ipfs && podman rm ipfs
        podman run -d \
            --pod web \
            --restart always \
            --name ipfs \
            -v ipfs-data:/data/ipfs \
            --cpus='0.25' \
            --memory='490m' \
            ipfs
    ;;
esac

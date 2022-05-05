#!/bin/sh

case "$1" in
    'nginx')
        podman stop nginx && podman rm nginx
        podman run -d \
            --restart=always \
            --name nginx \
            -p 80:80 \
            server
    ;;
    'ipfs')
        podman stop ipfs && podman rm ipfs
        podman run -d \
            --restart always \
            --name ipfs \
            -v ipfs-data:/data/ipfs \
            -v /staging:/staging:ro \
            -p 4001:4001 \
            -p 127.0.0.1:5001:5001 \
            -p 127.0.0.1:8080:8080 \
            docker.io/ipfs/go-ipfs
    ;;
esac

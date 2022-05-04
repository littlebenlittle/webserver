#!/bin/sh

case "$1" in
    'nginx')
        podman run -d \
            --restart=always \
            --name nginx \
            -v ./benlittledev.com:/www/data:ro \
            -p 80:80 \
            server
    ;;
    'ipfs')
        podman run -d \
            --restart always \
            --name ipfs \
            -v ipfs-data:/data/ipfs \
            -v /staging:/staging \
            -p 4001:4001 \
            -p 127.0.0.1:5001:5001 \
            -p 127.0.0.1:8080:8080 \
            docker.io/ipfs/go-ipfs
    ;;
esac

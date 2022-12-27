#!/bin/sh

set -e

run_nginx() {
if [ "$(id -u)" -eq "0" ]; then
    echo 'running as root'
    NGINX_PORT=80
else
    echo 'running as non-root user'
    NGINX_PORT=8090
fi
/usr/bin/podman run -d \
    --restart always \
    --name nginx \
    --publish "$NGINX_PORT":80 \
    --volume www-data:/www-data:ro \
    --cpus='0.10' \
    --memory='10m' \
    --log-opt='max-size=10m' \
    --network=slirp4netns \
    localhost/nginx
}

run_ipfs() {
/usr/bin/podman run -d \
    --restart always \
    --name ipfs \
    --publish 4001:4001 \
    --publish 127.0.0.1:5001:5001 \
    --publish 127.0.0.1:8080:8080 \
    --volume ipfs-data:/data/ipfs \
    --volume www-data:/www-data \
    --cpus='0.25' \
    --memory='490m' \
    --log-opt='max-size=10m' \
    --network=slirp4netns \
    localhost/ipfs
}

case "$1" in
    'nginx')
        run_nginx
    ;;
    'ipfs')
        run_ipfs
    ;;
    *)
        echo "use:"
        echo "$0 nginx"
        echo "OR"
        echo "$0 ipfs"
    ;;
esac

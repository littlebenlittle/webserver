#!/bin/sh

case "$1" in
    'nginx')
        cd ./nginx || exit 1
        /usr/bin/podman build -t nginx .
    ;;
    'ipfs')
        cd ./ipfs || exit 1
        /usr/bin/podman build -t ipfs .
    ;;
    *)
        echo "use:"
        echo "$0 nginx"
        echo "OR"
        echo "$0 ipfs"
    ;;
esac
#!/bin/sh

set -e

case "$1" in
    'nginx')
        podman stop nginx
        podman rm nginx
    ;;
    'ipfs')
        podman stop ipfs
        podman rm ipfs
    ;;
    *)
        echo "use:"
        echo "$0 nginx"
        echo "OR"
        echo "$0 ipfs"
    ;;
esac


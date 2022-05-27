#!/bin/sh

case "$1" in
    'nginx')
        if [ -z "$2" ]; then echo "use: $0 nginx <CID>"; exit 1; fi
        cid="$2"
        target="https://gateway.pinata.cloud/ipfs/$cid"
        cd ./nginx || exit 1
        sed -e "s|REDIRECT_TARGET|$target|" nginx.tmpl.conf >nginx.conf
        podman build -t nginx .
    ;;
    'ipfs')
        cd ./ipfs || exit 1
        podman build -t ipfs .
    ;;
    *)
        echo "use:"
        echo "$0 nginx <CID>"
        echo "OR"
        echo "$0 ipfs"
    ;;
esac


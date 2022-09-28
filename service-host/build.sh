#!/bin/sh

ctr_runtime=${CTR_RUNTIME:-podman}

case "$1" in
    'nginx')
        if [ -z "$2" ]; then echo "use: $0 nginx <CID>"; exit 1; fi
        cid="$2"
        cd ./nginx || exit 1
        sed -e "s|CID|$cid|" nginx.tmpl.conf >nginx.conf
        $ctr_runtime build -t nginx .
    ;;
    'ipfs')
        cd ./ipfs || exit 1
        $ctr_runtime build -t ipfs .
    ;;
    *)
        echo "use:"
        echo "$0 nginx <CID>"
        echo "OR"
        echo "$0 ipfs"
    ;;
esac

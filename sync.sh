#!/bin/sh

set -e

set -a
case $1 in
'monitor')
    cd monitor-host 
    #shellcheck source=./monitor-host/env
    . ./env
    ;;
'service')
    cd service-host 
    #shellcheck source=./service-host/env
    . ./env
    ;;
*)
    printf 'use:\n\tsync.sh <HOST>\n'
    exit 1
    ;;
esac

if [ -z "$REMOTE_DIR" ]; then echo 'sourcing env file did not work'; exit 1; fi
rsync -avzr --files-from ./include  . "$REMOTE_DIR"

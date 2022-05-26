#!/bin/sh

if [ -z "$REMOTE_DIR" ]; then echo "set REMOTE_DIR"; exit 1; fi
if [ -z "$1" ]; then echo "use $0 <file or dir>"; exit 1; fi

rsync -avz "$1" "$REMOTE_DIR"

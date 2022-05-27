#!/bin/sh

if [ -z "$REMOTE_DIR" ]; then echo "set REMOTE_DIR"; exit 1; fi

rsync -avzr --files-from ./include  . "$REMOTE_DIR"

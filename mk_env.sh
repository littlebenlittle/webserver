#!/bin/sh

if [ ! -d ./local ]; then mkdir ./local; fi

if [ -z "$1" ]; then fail=1; echo "A"; fi
if [ -z "$2" ]; then fail=1; echo "B"; fi
if [ -z "$3" ]; then fail=1; echo "C"; fi
if [ -n "$fail" ]; then echo "use: $0 <REMOTE_HOST> <REMOTE_USER> <REMOTE_DIR>"; exit 1; fi

host=$1
user=$2
dir=$3

cat >./local/env <<EOF
REMOTE_HOST="$host"
REMOTE_USER="$user@\$REMOTE_HOST"
REMOTE_DIR="\$REMOTE_USER:$dir"

export REMOTE_HOST
export REMOTE_USER
export REMOTE_DIR

EOF

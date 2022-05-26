#!/bin/sh

cd nginx || exit 1
podman build -t server .
cd ../ipfs || exit 1
podman build -t ipfs .

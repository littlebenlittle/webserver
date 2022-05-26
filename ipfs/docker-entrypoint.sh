#!/bin/sh

chown -R ipfs /data/ipfs
/usr/local/bin/start_ipfs daemon --migrate=true --agent-version-suffix=docker

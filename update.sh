#!/bin/sh

sed -e "s|REDIRECT|https://$1.ipfs.dweb.link/|" ./src/index.html > benlittledev.com/index.html
./build.sh
./run.sh nginx

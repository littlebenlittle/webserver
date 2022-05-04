#!/bin/sh

sed -e "s|REDIRECT|https://$1.dweb.link/|" ./src/index.html > benlittledev.com/index.html

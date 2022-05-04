#!/bin/sh

sed -e "s|REDIRECT|$1|" ./src/index.html > benlittledev.com/index.html

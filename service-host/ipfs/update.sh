#!/bin/sh

set -x

if ipfs get -o /tmp/www-data "$1"
then
    if [ "0" -ne "$(ls /www-data | wc -l)" ]
    then
        if [ -e /tmp/www-data-old ]
        then
            rm -r /tmp/www-data-old
        fi
        mkdir /tmp/www-data-old
        mv /www-data/* /tmp/www-data-old
    fi
    mv /tmp/www-data/* /www-data
fi

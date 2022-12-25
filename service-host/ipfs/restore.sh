#!/bin/sh
#
set -x

if [ -e /tmp/www-data-old ]
then
    if [ -e /tmp/www-data-restore ]
    then
        rm -r /tmp/www-data-restore
    fi
    mkdir /tmp/www-data-restore
    mv /www-data/* /tmp/www-data-restore
    mv /tmp/www-data-old/* /www-data
else
    echo "/tmp/www-data-old does not exist"
fi

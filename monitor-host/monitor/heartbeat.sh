#!/bin/sh

date

if [ -z "$SERVICE_LINODE_ID" ]; then
    echo 'make sure SERVICE_LINODE_ID is set'
    exit 1
fi

LINODE_CLI_TOKEN=$(cat /run/secrets/linode-access-token)
if [ -z "$LINODE_CLI_TOKEN" ]; then
    echo 'make sure access token is mounted with --secret linode-access-token'
    exit 1
fi

export LINODE_CLI_TOKEN

timelock=/tmp/monitor.lastreset.seconds

if wget -q --spider -T 30 https://benlittle.dev; then
    echo 'site index loaded OK'
else
    echo 'site index failed to load'

    if [ ! -f $timelock ]; then
        date +%s >$timelock
    fi

    elapsed=$(( $(date +%s) - $(cat $timelock) ))
    if [ $elapsed -lt 300 ]; then
        echo "last reset was $elapsed seconds ago"
        exit 0
    fi

    echo "rebooting service VM"
    linode-cli linodes reboot "$SERVICE_LINODE_ID"
    date +%s >$timelock
fi

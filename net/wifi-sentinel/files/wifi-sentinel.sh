#!/bin/sh
. /lib/functions/network.sh

PACKETS='3'
INTERVAL='10'
STATUS='unknown'
NETWORK='management'
PORT='1'

lightsoff()
{
    if [ "$STATUS" != 'down' ]; then
        /usr/bin/logger -t wifi-sentinel -p daemon.alert Shutting down wireless interfaces due to lack of connectivity to the gateway.
        /sbin/wifi down
        STATUS='down'
    fi
}

lightson()
{
    if [ "$STATUS" != 'up' ]; then
        /usr/bin/logger -t wifi-sentinel -p daemon.notice Bringing up wireless interfaces. Gateway connectivity restored.
        /sbin/wifi up
        STATUS='up'
    fi
}

port_check()
{
    LINK=`swconfig dev switch0 port 1 show | awk '/link/ {print $3}'`
    if [ "$LINK" = 'link:up' ]; then
        return 0
    else
        return 1
    fi
}

ping_check()
{
    local target
    network_get_gateway target $NETWORK
    RET=`ping -c $PACKETS $target 2> /dev/null | awk '/packets received/ {print $4}'`
    if [ "$RET" -eq "$PACKETS" ]; then
        return 0
    else
        return 1
    fi
}

/usr/bin/logger -t wifi-sentinel -p daemon.info "Starting Wi-Fi Sentinel on the $NETWORK network with $PACKETS checks every $INTERVAL seconds."

while true ; do
    if port_check && ping_check; then
        lightson
    else
        lightsoff
    fi
    sleep $INTERVAL
done

#!/bin/bash

usage(){
    echo ""
    echo "Issue an IPMI command to local node by index"
    echo "Usage: $0 <node index> '<ipmi command>'"
    echo "Example: $0 37 'power cycle' reboots node37"
    echo "         $0 37 'chassis status' to see if node37 is up"
    echo "         $0 37 '-I lanplus sol activate' to activate serial-over-LAN"
    echo ""
    exit 1
}

[[ $# -eq 0 ]] && usage

SUBNET="192.168.0."
USER="root"
PASS="{{ ipmi_password }}"
INDEX=$(hostname|perl -ne 'm|node(\d+)\.(.*)\.vicci\.org|&&print $1')
REMOTEIP="$SUBNET$1"

NEWIDX=`expr $INDEX + 70`
MYIP="$SUBNET$NEWIDX"
NETDEV=em1

ip addr add $MYIP/24 dev $NETDEV

CMD="ipmitool -H $REMOTEIP -U $USER -P $PASS $2"
echo "Running: $CMD"
echo ""
$CMD

ip addr del $MYIP/24 dev $NETDEV

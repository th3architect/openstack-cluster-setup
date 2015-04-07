#!/bin/sh

source ~/admin_openrc.sh

OVX_FLOODLIGHT_URL=http://www.vicci.org/opencloud/ubuntu-14.04-server-cloudimg-amd64-disk1-ovx-floodlight.img

# Install ovx-floodlight image
glance image-show ovx-floodlight 2&>1 > /dev/null
if [ "$?" -ne 0 ]
then
    glance image-create --name ovx-floodlight --disk-format=qcow2 --container-format=bare --copy-from=$OVX_FLOODLIGHT_URL
fi




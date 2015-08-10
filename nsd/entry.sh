#!/bin/sh

[ ! -f "/etc/nsd/nsd_server.key" ] && nsd-control-setup
chown nsd:nsd /etc/nsd/nsd_control.key /etc/nsd/nsd_control.pem /etc/nsd/nsd_server.pem

exec $@

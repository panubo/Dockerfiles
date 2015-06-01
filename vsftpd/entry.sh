#!/usr/bin/env bash

set -e

if [ ! -z "$FTP_USER" -a ! -z "$FTP_PASSWORD" ]; then
    /add-virtual-user.sh -d "$FTP_USER" "$FTP_PASSWORD"
fi

echo "Running $@"
$@ &
wait && exit $? 

# TODO: Fix this process exec
#tail -f /var/log/vsftpd.log
#exec "$@"

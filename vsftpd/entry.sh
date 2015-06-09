#!/usr/bin/env bash

set -e

if [ ! -z "$FTP_USER" -a ! -z "$FTP_PASSWORD" ]; then
    /add-virtual-user.sh -d "$FTP_USER" "$FTP_PASSWORD"
fi

function vsftpd_stop {
  echo "Received SIGINT or SIGTERM. Shutting down vsftpd"
  # Get PID
  pid=$(cat /var/run/vsftpd/vsftpd.pid)
  # Set TERM
  kill -SIGTERM "${pid}"
  # Wait for exit
  wait "${pid}"
  # All done.
  echo "Done"
}

trap vsftpd_stop SIGINT SIGTERM

echo "Running $@"
$@ &
pid="$!"
echo "${pid}" > /var/run/vsftpd/vsftpd.pid
wait "${pid}" && exit $? 

# TODO: Fix this process exec
#tail -f /var/log/vsftpd.log
#exec "$@"

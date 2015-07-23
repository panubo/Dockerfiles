#!/usr/bin/env bash

echo "=== Run CouchDB ==="

VOLUME_DB="/var/lib/couchdb"

if [ -n "$(ls -A ${VOLUME_DB})" ]; then
    echo "=> Using an existing volume in $VOLUME_DB"
else
    echo "=> An empty or uninitialized CouchDB volume is detected in $VOLUME_DB"
    /initialise_couch.sh
    if [[ $? -ne 0 ]]; then
        echo "=> Failed to Initialise CouchDB!"
        exit 128
    fi
fi

function couchdb_stop {
  echo "Received SIGINT or SIGTERM. Shutting down CouchDB"
  # Get PID
  pid=$(cat /var/run/couchdb/couchdb.pid)
  # Set TERM
  kill -SIGTERM "${pid}"
  # Wait for exit
  wait "${pid}"
  # All done.
  echo "Done"
}

trap couchdb_stop SIGINT SIGTERM

echo "=> Starting CouchDB"
/usr/local/bin/voltgrid.py /usr/libexec/couchdb +Bd -noinput -sasl errlog_type error +K true +A 4 -couch_ini /etc/couchdb/default.ini /etc/couchdb/default.d/ /etc/couchdb/local.d/ /etc/couchdb/local.ini -s couch -pidfile /var/run/couchdb/couchdb.pid &

sleep infinity && exit $?

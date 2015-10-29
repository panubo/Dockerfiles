#!/usr/bin/env bash

[ "$DEBUG" == 'true' ] && set -x

echo "=== Run CouchDB ==="

VOLUME_DB="/var/lib/couchdb"
export COUCHDB_URL=${COUCHDB_URL-http://127.0.0.1:5984/}

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

RC=1; I=0
echo -n "=> Waiting for CouchDB startup"
while [[ RC -ne 0 ]]; do
    echo -n '.'
    sleep 1
    curl ${COUCHDB_URL} > /dev/null 2>&1
    RC=$?
    I=$((I+1))
    if [[ I -gt 15 ]]; then
        echo " Failed to start."
        exit 128
    fi
done
echo " Started."

# Create a user if we don't have any admins, in the case that /etc/couchdb is not retained between restarts
if [ -n "${COUCHDB_USER}" ] && [ -n "${COUCHDB_PASS}" ] && [ "$(curl -s ${COUCHDB_URL}_config/admins/)" == "{}" ]; then
    echo -n "=> Creating CouchDB Admin User: \"${COUCHDB_USER}\". "
    curl -X PUT ${COUCHDB_URL}_config/admins/${COUCHDB_USER} -d \"${COUCHDB_PASS}\" > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error."
        exit 128
    else
        echo "Done."
    fi
fi

sleep infinity && exit $?

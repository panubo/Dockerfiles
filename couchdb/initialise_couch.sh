#!/usr/bin/env bash

COUCHDB_URL=${COUCHDB_URL-http://127.0.0.1:5984/}

echo "=== Initialising CouchDB ==="

echo "=> Starting CouchDB Server"
/usr/local/bin/voltgrid.py /usr/libexec/couchdb +Bd -noinput -sasl errlog_type error +K true +A 4 -couch_ini /etc/couchdb/default.ini /etc/couchdb/default.d/ /etc/couchdb/local.d/ /etc/couchdb/local.ini -s couch -pidfile /var/run/couchdb/couchdb.pid > /dev/null 2>&1 &

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

if [ -n "${COUCHDB_DATABASE}" ]; then
    echo -n "=> Creating CouchDB Database: \"${COUCHDB_DATABASE}\". "
    curl -X PUT ${COUCHDB_URL}${COUCHDB_DATABASE} > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error."
        exit 128
    else
        echo "Done."
    fi
fi

if [ -n "${COUCHDB_USER}" ] && [ -n "${COUCHDB_PASS}" ]; then
    echo -n "=> Creating CouchDB Admin User: \"${COUCHDB_USER}\". "
    curl -X PUT ${COUCHDB_URL}_config/admins/${COUCHDB_USER} -d \"${COUCHDB_PASS}\" > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error."
        exit 128
    else
        echo "Done."
    fi
fi

echo "=> Stopping CouchDB Server."
kill `cat /var/run/couchdb/couchdb.pid`
echo "=> All Done."

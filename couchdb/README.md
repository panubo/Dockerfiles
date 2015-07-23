# CouchDB

## Use

If `COUCHDB_DATABASE` is specified then an empty database will be created when the volume is initialised.
If `COUCHDB_USER` and `COUCHDB_PASS` is specified then an admin user will be created when the volume is initialised.

    docker run --publish=5984:5984 -e COUCHDB_DATABASE=baz -i -t panubo/couchdb

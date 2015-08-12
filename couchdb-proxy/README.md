## CouchDB Proxy

Simply a Nginx reverse proxy for CouchDB. Provides the ability to encrypt communications and use client certificate authentication.

## Usage

This container requires ETCDCTL_PEERS COUCHDB_SERVICE and a set of certificates. COUCHDB_SERVICE defaults to "couchdb"

Example:

```
ls ssl/
ca.pem
crl.pem
server.pem
docker run --rm -it -e ETCDCTL_PEERS=${ETCDCTL_PEERS} -e COUCHDB_SERVICE=dnscouch -v `pwd`/ssl:/etc/nginx/conf.d/ssl panubo/couchdb-proxy
```

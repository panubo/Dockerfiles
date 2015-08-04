#!/usr/bin/env bash

set -ex

function populate() {
    SOURCE=$1
    TARGET=$2

    if [ ! -d "$TARGET" ]; then
        cp -a "$SOURCE" "$TARGET"
    fi
    rm -rf "$SOURCE" && ln -s "$TARGET" "$SOURCE"
}

# Bind Config Dir
mkdir -p /data && chown -R root:bind /data && chmod 775 /data

# Populate Default Config
populate /etc/bind /data/etc
populate /var/lib/bind /data/lib
populate /var/cache/bind /data/cache

# Make daemon dirs
mkdir -m 0775 -p /var/run/named
chown root:bind /var/run/named

echo "Exec'ng $@"
exec "$@"

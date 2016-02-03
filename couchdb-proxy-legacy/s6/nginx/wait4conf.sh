#!/bin/sh

echo "$(date --rfc-3339=seconds --utc) Waiting for config to be created."

while sleep 1; do
	if [ -f "/etc/nginx/conf.d/nginx.conf" ]; then
		echo "$(date --rfc-3339=seconds --utc) Config created. Starting nginx."
		exit 0
	fi
done

# Shouldn't get here, infant loop.
exit 1
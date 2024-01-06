#!/bin/sh

if [ "$(uname -m)" = "x86_64" ]; then
  sleep 5 && /usr/local/bin/temporal-amd64 operator namespace update --retention 30 default && /usr/local/bin/temporal-amd64 operator namespace list &
  exec /usr/local/bin/temporal-amd64 server start-dev --db-filename /data/temporal.db --ip 0.0.0.0 --namespace default --namespace temporal-system
elif [ "$(uname -m)" = "aarch64" ]; then
  sleep 5 && /usr/local/bin/temporal-arm64 operator namespace update --retention 30 default && /usr/local/bin/temporal-arm64 operator namespace list &
  exec /usr/local/bin/temporal-arm64 server start-dev --db-filename /data/temporal.db --ip 0.0.0.0 --namespace default --namespace temporal-system
else
  echo "Unsupported architecture: $(uname -m)"
  exit 1
fi


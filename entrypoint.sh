#!/bin/sh
if [ "$(uname -m)" = "x86_64" ]; then
  exec /usr/local/bin/temporal-amd64 "$@"
elif [ "$(uname -m)" = "aarch64" ]; then
  exec /usr/local/bin/temporal-arm64 "$@"
else
  echo "Unsupported architecture: $(uname -m)"
  exit 1
fi

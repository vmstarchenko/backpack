#!/usr/bin/env bash

set -eu

echo "Install firejail configs"
if ! command -v firejail &> /dev/null; then
  echo "WARNING: firejail not exists, skip install";
  exit 0;
fi

cd "$(dirname "$0")"
mkdir ~/.config/firejail -p
cp -a ./settings/. ~/.config/firejail

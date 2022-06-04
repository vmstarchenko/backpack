#!/usr/bin/env bash

set -eu

echo "Sync bash configs"

cd "$(dirname "$0")"

val=$(sed -n '/LOCALS HERE/,/LOCALS END/p' ~/.bashrc)


if [ -z "$val" ]; then
  echo "WARNING: Bash local section not found, skip";
  exit 0;
fi

echo -ne "$val" > ./.bashrc
echo "Bash configs synced"

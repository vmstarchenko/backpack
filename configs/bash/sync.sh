#!/usr/bin/env bash

set -eu

echo "Sync bash configs"

cd "$(dirname "$0")"

val=$(sed -n '/LOCALS HERE/,/LOCALS END/p' ~/.bashrc)

[ -z "$val" ] && exit 0;

echo -ne "$val" > ./.bashrc
echo "Bash configs synced"

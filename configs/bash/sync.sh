#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Sync bash configs"

sed -n '/LOCALS HERE/,/LOCALS END/p' ~/.bashrc > ./.bashrc

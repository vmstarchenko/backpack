#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Sync bin configs"

cp ~/.local/bin/* ./bin -r

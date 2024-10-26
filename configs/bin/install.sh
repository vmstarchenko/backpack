#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Sync bin configs"

mkdir -p ~/.local/bin
ln -s `pwd`/bin/* ~/.local/bin/ || true

#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Install lib configs"

mkdir -p ~/lib
ln -s `pwd`/lib/* ~/lib/ || true

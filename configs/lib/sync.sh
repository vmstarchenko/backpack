#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Sync lib configs"

cp ~/lib/* ./lib -r

#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

./bash/sync.py
./vim/sync.sh
# ./firejail/sync.sh
./lib/sync.sh
./bin/sync.sh

#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

./bash/install.py "$@"
./vim/install.sh "$@"
./firejail/install.sh
./bin/install.sh
./lib/install.sh

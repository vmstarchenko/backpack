#!/usr/bin/env bash

set -eu
cd "$(dirname "$0")"

./bash/install.sh
./vim/install.sh
./firejail/install.sh

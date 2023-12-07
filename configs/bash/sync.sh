#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Sync bash configs"

if ! [ -h "$HOME/.bashrc_custom" ]; then
  cp ~/.bashrc_custom .bashrc
fi

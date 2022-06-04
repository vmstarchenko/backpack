#!/usr/bin/env bash

set -eu

echo "Install bash configs"

cd "$(dirname "$0")"
if grep -q "# LOCALS HERE" ~/.bashrc; then
  echo "WARNING: skip .bashrc init (locals section exists)"
else
  echo -ne "\n\n" >> ~/.bashrc
  cat .bashrc >> ~/.bashrc
fi

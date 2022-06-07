#!/usr/bin/env bash

set -eu

echo "Sync bash configs"

cd "$(dirname "$0")"

python3 <<EOF
import os, re

with open(os.path.expanduser("~/.bashrc")) as inp:
    value = re.search(r"# LOCALS HERE(.|\n)*# LOCALS END", inp.read())

if not value:
    print("WARNING: Bash local section not found, skip")
else:
    with open(".bashrc", "w") as out:
        out.write(value.group())
    print("Bash configs synced")
EOF

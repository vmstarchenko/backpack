#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Sync vim configs"

cp ~/.vimrc .vimrc
cp ~/.vim/colors/xop2.vim xop2.vim

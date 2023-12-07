#!/usr/bin/env bash

set -exu

cd "$(dirname "$0")"

echo "Sync vim configs"

if ! [ -h "$HOME/.vimrc" ]; then
  cp ~/.vimrc .vimrc
fi

if ! [ -h "$HOME/.vim/colors/xop2.vim" ]; then
  cp ~/.vim/colors/xop2.vim xop2.vim
fi

#!/usr/bin/env bash

set -eu

echo "Install vim configs"
if ! command -v vim &> /dev/null; then
  echo "WARNING: vim not exists, skip install";
  exit 0;
fi

cd "$(dirname "$0")"

cmp --silent .vimrc ~/.vimrc || cp -i .vimrc ~/.vimrc
cmp --silent xop2.vim ~/.vim/colors/xop2.vim || (
  mkdir ~/.vim/colors -p && cp -i xop2.vim ~/.vim/colors/xop2.vim
)

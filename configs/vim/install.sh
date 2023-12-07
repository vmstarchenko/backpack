#!/usr/bin/env bash

set -eu

echo "Install vim configs"
if ! command -v vim &> /dev/null; then
  echo "WARNING: vim not exists, skip install";
  exit 0;
fi


cd "$(dirname "$0")"


if [[ $* == *--copy* ]];
then
  cmp --silent .vimrc ~/.vimrc || cp -i .vimrc ~/.vimrc
  cmp --silent xop2.vim ~/.vim/colors/xop2.vim || (
    mkdir ~/.vim/colors -p && cp -i xop2.vim ~/.vim/colors/xop2.vim
  )
else
  ROOT=`pwd`
  cmp --silent .vimrc ~/.vimrc || (
    rm ~/.vimrc && ln -s $ROOT/.vimrc ~/.vimrc
  )
  cmp --silent xop2.vim ~/.vim/colors/xop2.vim || (
    mkdir ~/.vim/colors -p && ln -s $ROOT/xop2.vim ~/.vim/colors/xop2.vim
  )

fi

exit 0;



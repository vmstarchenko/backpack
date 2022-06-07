"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'

"Plugin 'sheerun/vim-polyglot'
"call vundle#end()    


filetype plugin on
filetype indent plugin on

set wildmenu
 
syntax on
set nowrap
set number

set nocompatible

 
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
 
filetype plugin indent on
"set tabstop=4
"set shiftwidth=4
"set expandtab

"augroup typescript
"  au!
"  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
"  autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
"augroup END

"augroup css
"  au!
"  autocmd BufNewFile,BufRead *.scss set filetype=css
"  autocmd FileType css setlocal shiftwidth=2 tabstop=2
"augroup END


colo xop2

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab

set autoread

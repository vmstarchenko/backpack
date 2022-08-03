"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'

"Plugin 'sheerun/vim-polyglot'
"call vundle#end()    


filetype plugin on
filetype indent plugin on

syntax on
set autoindent
set autoread
set expandtab
set nocompatible
set nowrap
set number
set shiftwidth=4
set smartindent
set tabstop=4
set wildmenu

augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
 
filetype plugin indent on

colo xop2

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2 shiftwidth=2 tabstop=2 expandtab
autocmd FileType typescript setlocal ts=2 sts=2 sw=2 shiftwidth=2 tabstop=2 expandtab
autocmd FileType python setlocal foldmethod=indent

" FOLD
"" remember fold
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

set foldmethod=syntax
set foldnestmax=2
set nofoldenable
set foldlevel=2

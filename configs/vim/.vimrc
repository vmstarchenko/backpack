"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'VundleVim/Vundle.vim'

"Plugin 'sheerun/vim-polyglot'
"call vundle#end()    


filetype plugin on
filetype indent plugin on

syntax on
"set autoindent
set autoread
set expandtab
set nocompatible
set nowrap
set wrap
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


au BufRead,BufNewFile,BufReadPost *.yml set filetype=yaml
"autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>

autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType typescriptreact,typescript setlocal ts=2 sts=2 sw=2 shiftwidth=2 tabstop=2 expandtab
autocmd FileType python setlocal foldmethod=indent
set equalprg=clang-format2

"https://stackoverflow.com/questions/39553825/vim-double-indents-python-files
let g:pyindent_open_paren=4

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

" braces
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''\<Left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> ` strpart(getline('.'), col('.')-1, 1) == "`" ? "\<Right>" : "``\<Left>"

function PreviousCharacter() abort
    return matchstr(getline('.'), '.\%'.col('.').'c')
endfunction

function CurrentCharacter() abort
    return matchstr(getline('.'), '\%'.col('.').'c.')
endfunction

function CursorIsBetweenBrackets(bracketSets = ["{}"])
    let prev = PreviousCharacter()
    let curr = CurrentCharacter()

	if prev == '(' && curr == ')'
		return 1
    elseif prev == '{' && curr == '}'
        return 1
    elseif prev == '[' && curr == ']'
        return 1
	endif

    return 0
endfunction

inoremap <silent><expr> <cr> CursorIsBetweenBrackets() ? "\<c-g>u\<cr>\<Up>\<End>\<cr>" : "\<c-g>u\<cr>"

" tree
"let g:netrw_banner = 0
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25

"augroup ProjectDrawer
"      autocmd!
"      autocmd VimEnter * :Vexplore
"augroup END

let g:cssColorVimDoNotMessMyUpdatetime = 1

" set equalprg=clang-format
" autocmd FileType cpp local equalprg=clang-format

inoremap <expr> <Tab> getline('.')[col('.')-2] !~ '^\s\?$' \|\| pumvisible()
      \ ? '<C-N>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() \|\| getline('.')[col('.')-2] !~ '^\s\?$'
      \ ? '<C-P>' : '<Tab>'
autocmd CmdwinEnter * inoremap <expr> <buffer> <Tab>
      \ getline('.')[col('.')-2] !~ '^\s\?$' \|\| pumvisible()
      \ ? '<C-X><C-V>' : '<Tab>'

" fixing up moving line by line in the paragraph
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap g[ <C-t>

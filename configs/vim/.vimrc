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
function! CountCharsFull(str, char)
  let char_count = 0
  let i = 0
  while i < strlen(a:str)
    if a:str[i] == a:char
      let char_count += 1
    endif
    let i += 1
  endwhile
  return char_count
endfunction

function! CountChars(string, char)
  return strlen(substitute(a:string, '[^' . a:char . ']', '', 'g'))
endfunction

" Функция для проверки баланса скобок и условной вставки
function! BalancedPairMap(open, close)
  let line = getline('.')
  let col = col('.') - 1  " col('.') возвращает позицию курсора начиная с 1, а индексы в строке начинаются с 0
  
  " Подсчитываем количество открывающих и закрывающих скобок в части строки до курсора
  let open_count = CountChars(line, a:open)
  let close_count = CountChars(line, a:close)
  
  " Вставляем закрывающую скобку только если количество открывающих скобок превышает количество закрывающих
  if open_count >= close_count
    return a:open . a:close . "\<Left>"
  else
    return a:open
  endif
endfunction

" Применяем функцию к фигурным скобкам
inoremap <expr> { BalancedPairMap('{', '}')
inoremap <expr> ( BalancedPairMap('(', ')')
inoremap <expr> [ BalancedPairMap('[', ']')
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" Функция для умной вставки кавычек
function! SmartQuotes(quote)
  let line = getline('.')
  let col = col('.') - 1  " col('.') возвращает позицию курсора начиная с 1, а индексы в строке начинаются с 0
  
  " Проверяем, находится ли курсор на кавычке
  let on_quote = col < len(line) && line[col] == a:quote
  
  " Считаем общее количество кавычек в строке
  let quote_count = CountChars(line, a:quote)
  
  " Если количество кавычек четное и курсор стоит на кавычке
  if quote_count % 2 == 0 && on_quote
    return "\<Right>"  " Перемещаем курсор вправо без вставки
  " Если количество кавычек четное (или ноль)
  elseif quote_count % 2 == 0
    return a:quote . a:quote . "\<Left>"  " Вставляем пару кавычек и перемещаем курсор между ними
  " Если количество кавычек нечетное
  else
    return a:quote  " Вставляем только одну кавычку
  endif
endfunction

" Применяем функцию к двойным кавычкам
inoremap <expr> " SmartQuotes('"')
" Применяем функцию к одинарным кавычкам (если нужно)
inoremap <expr> ' SmartQuotes("'")
inoremap <expr> ` SmartQuotes('`')

" переводы строк
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

nnoremap ds :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Поиск
let mapleader = ","
" Подсветка совпадений поиска
set hlsearch

function! SearchAndReplace(search_text)
  let search = a:search_text == "" ? input("Search for: ", expand("<cword>")) : a:search_text
  if search == "" | return | endif
  if !exists("s:last_replace")
	let s:last_replace = ""
  endif
  let replace = input("Replace with: ", s:last_replace)
  let s:last_replace = replace
  call feedkeys(":%s/" . search . "/" . replace . "/gc", "n")
endfunction

vnoremap <leader>s :call SearchAndReplace("<C-r><C-w>")<CR>
nnoremap <leader>s :call SearchAndReplace("")<CR>

set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

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

" Устанавливаем пробел как leader клавишу
let mapleader = ","
" nnoremap <Space> <Nop>
set notimeout
set ttimeout
set ttimeoutlen=100

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

nnoremap <leader>o :tabedit 
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q
nnoremap <leader>q! :q!
nnoremap <leader>qa :qa

" FOLD
"" remember fold
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

set foldenable
set foldmethod=indent
set foldnestmax=20
set foldlevel=20

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
  else
    return a:quote  " Вставляем только одну кавычку
  endif
endfunction

inoremap <expr> " SmartQuotes('"')
inoremap <expr> ' SmartQuotes("'")
inoremap <expr> ` SmartQuotes('`')

" call writefile([string(getpos('.')[1:2]) . " " . string(getpos("'<")[1:2]) . " " . string(getpos("'>")[1:2]) . " " . cursor_at_start . " " . cursor_line . " " . cursor_col], "/tmp/vim_debug.log", "a")
function! SurroundSelection(open, close)
    let cursor_pos = getpos('.')[1:2]

    let cursor_line = line('.')
    let cursor_col = col('.')
    
    " Получаем начало и конец выделения
    let [line_start, col_start] = getpos("'<")[1:2]
    let [line_end, col_end] = getpos("'>")[1:2]
   
    let cursor_at_start = (cursor_pos[0] == line_start && cursor_pos[1] == col_start) 
    
    " Добавляем закрывающий символ в конец выделения
    call cursor(line_end, col_end)
    execute "normal! a" . a:close
    
    " Добавляем открывающий символ в начало выделения
    call cursor(line_start, col_start)
    execute "normal! i" . a:open
    
    " Корректируем новые позиции выделения
    let new_col_start = col_start + len(a:open)
    let new_col_end = col_end + len(a:open)
    
    if cursor_at_start
        call cursor(line_end, new_col_end)
        execute "normal! \<Esc>v"
        call cursor(line_start, new_col_start)
    else
        call cursor(line_start, new_col_start)
        execute "normal! \<Esc>v"
        call cursor(line_end, new_col_end)
    endif
endfunction

vnoremap <silent> <leader>( <Esc>:call SurroundSelection('(', ')')<CR>
vnoremap <silent> <leader>) <Esc>:call SurroundSelection('(', ')')<CR>
vnoremap <silent> <leader>[ <Esc>:call SurroundSelection('[', ']')<CR>
vnoremap <silent> <leader>] <Esc>:call SurroundSelection('[', ']')<CR>
vnoremap <silent> <leader>{ <Esc>:call SurroundSelection('{', '}')<CR>
vnoremap <silent> <leader>} <Esc>:call SurroundSelection('{', '}')<CR>
vnoremap <silent> <leader>" <Esc>:call SurroundSelection('"', '"')<CR>
vnoremap <silent> <leader>' <Esc>:call SurroundSelection("'", "'")<CR>
vnoremap <silent> <leader>` <Esc>:call SurroundSelection('`', '`')<CR>


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
set hlsearch " Подсветка совпадений поиска

function! GetSelectedText()
    call SaveRegister()
    
    execute 'silent normal! gv"' . s:fallback_register . 'y'
    let selected_text = getreg(s:fallback_register)
    
    call RestoreRegister()
    return selected_text
endfunction

function! SearchAndReplace(search_text)
  let search = a:search_text == "" ? input("Replace from: ", expand("<cword>")) : a:search_text
  if search == "" | return | endif
  if !exists("s:last_replace")
	let s:last_replace = ""
  endif
  let replace = input("Replace with: ", s:last_replace)
  let s:last_replace = replace
  call feedkeys(":%s/" . search . "/" . replace . "/gc", "n")
endfunction

vnoremap <leader>r :call SearchAndReplace(GetSelectedText())<CR>
nnoremap <leader>r :call SearchAndReplace("")<CR>

function! Search(search_text)
  let search = a:search_text == "" ? expand("<cword>") : a:search_text
  if search == "" | return | endif
  call feedkeys("/" . search, "n")
endfunction

vnoremap <leader>f :call Search(GetSelectedText())<CR>
nnoremap <leader>f :call Search("")<CR>


set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

let g:llama_config = {
    \ 'show_info': 0,
    \ 'keymap_trigger': '<leader>l',
    \ }

" Vim config for cross-platform clipboard interaction
" Leader key setup (uncomment to change)
" let mapleader = ","

" Function to check clipboard support
function! HasClipboardSupport()
  return has('clipboard') || has('xterm_clipboard')
endfunction

" Function to check if xclip is available
function! HasXClip()
  return executable('xclip')
endfunction

" Dedicated register for fallback
let s:fallback_register = 'z'

" Save original register content before operations
function! SaveRegister()
  let s:saved_reg = getreg(s:fallback_register)
  let s:saved_regtype = getregtype(s:fallback_register)
endfunction

" Restore register content after operations
function! RestoreRegister()
  call setreg(s:fallback_register, s:saved_reg, s:saved_regtype)
endfunction

" Setup mappings based on available methods
if HasClipboardSupport()
  nnoremap <leader>c "+y
  vnoremap <leader>c "+y
  nnoremap <leader>x "+d
  vnoremap <leader>x "+d
  nnoremap <leader>v "+p
  vnoremap <leader>v "+p
  nnoremap <leader>V "+P
  vnoremap <leader>V "+P
  inoremap <C-,> <C-r>+
  inoremap <C-.> <Esc>"+Pi

elseif HasXClip()
  vnoremap <silent> <leader>c :w !xclip -selection clipboard<CR><CR>
  nnoremap <silent> <leader>c :w !xclip -selection clipboard<CR><CR>
  vnoremap <silent> <leader>x :w !xclip -selection clipboard<CR>gvd<CR>
  nnoremap <silent> <leader>x :w !xclip -selection clipboard<CR>dd<CR>
  nnoremap <silent> <leader>v :r !xclip -selection clipboard -o<CR>
  vnoremap <silent> <leader>v c<ESC>:r !xclip -selection clipboard -o<CR>
  nnoremap <silent> <leader>V :-1r !xclip -selection clipboard -o<CR>
  vnoremap <silent> <leader>V c<ESC>:-1r !xclip -selection clipboard -o<CR>
  inoremap <silent> <C-,> <ESC>:r !xclip -selection clipboard -o<CR>a
  inoremap <silent> <C-.> <ESC>:-1r !xclip -selection clipboard -o<CR>a

else
  nnoremap <silent> <leader>c :call SaveRegister()<CR>"zy:call RestoreRegister()<CR>
  vnoremap <silent> <leader>c :call SaveRegister()<CR>"zy:call RestoreRegister()<CR>
  nnoremap <silent> <leader>x :call SaveRegister()<CR>"zd:call RestoreRegister()<CR>
  vnoremap <silent> <leader>x :call SaveRegister()<CR>"zd:call RestoreRegister()<CR>
  nnoremap <silent> <leader>v :call SaveRegister()<CR>"zp:call RestoreRegister()<CR>
  vnoremap <silent> <leader>v :call SaveRegister()<CR>"zp:call RestoreRegister()<CR>
  nnoremap <silent> <leader>V :call SaveRegister()<CR>"zP:call RestoreRegister()<CR>
  vnoremap <silent> <leader>V :call SaveRegister()<CR>"zP:call RestoreRegister()<CR>
  " Using Ctrl+, for insert mode with saved register
  inoremap <silent> <C-,> <C-r>=SaveRegister()<CR><C-r>z<C-r>=RestoreRegister()<CR>
  inoremap <silent> <C-.> <Esc>:call SaveRegister()<CR>"zPi<C-r>=RestoreRegister()<CR>
endif

inoremap jk <esc>

set nofixeol

set number
set nocompatible
set history=1000
syntax on

set autoindent
" set smartindent
set noexpandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2

set ruler
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=green
set incsearch
set showmatch

set wrap
set textwidth=0 wrapmargin=0
set nolinebreak
" set textwidth=75
" set colorcolumn=80

" set lisp " including hyphenated words as key-words, useful when writing HTML classNames.

if has("multi_byte")
	set encoding=utf-8
	set termencoding=utf-8
	set formatoptions+=mM
	set fencs=utf-8,gbk
	if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
		set ambiwidth=double
	endif
endif

" colorscheme default
colorscheme koehler

nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-l> :Explore<CR>
nnoremap <C-k> :set nopaste<enter>

let g:netrw_liststyle = 1
let g:netrw_browse_split = 0
" let g:netrw_banner = 0
" let g:netrw_winsize = 25

filetype plugin indent on

inoremap {<CR> {<CR>}<esc>ko

autocmd BufNewFile *.html 0r ~/.vim/templates/html.template

" highlight ExtraWhitespace ctermbg=yellow guibg=yellow
" match ExtraWhiteSpace /\s\+$/

function RemoveExtraWhiteSpaces()
	:mark `
	:%s/\s\+$//e
	:normal ``
endfunction

command RemoveExtraWhiteSpaces :call RemoveExtraWhiteSpaces()

" nnoremap <C-[> :execute "vertical ptag " . expand("<cword>")<CR>
" nnoremap <C-[> <esc>:vs<CR><C-]>

function SetSpaceIndentation(sp)
	let &softtabstop=a:sp
	let &tabstop=a:sp
	let &shiftwidth=a:sp
	set expandtab
	echo('Indent with space: ' . a:sp)
endfunction

function SetTabIndentation(tabwidth)
	let &softtabstop=a:tabwidth
	let &tabstop=a:tabwidth
	let &shiftwidth=a:tabwidth
	set noexpandtab
	echo('Indent with tab: tabwidth: ' . a:tabwidth)
endfunction

inoremap <f2>2 <esc>:call SetSpaceIndentation(2)<enter>
nnoremap <f2>2      :call SetSpaceIndentation(2)<enter>
inoremap <f2>4 <esc>:call SetSpaceIndentation(4)<enter>
nnoremap <f2>4      :call SetSpaceIndentation(4)<enter>

inoremap <f3>2 <esc>:call SetTabIndentation(2)<enter>
nnoremap <f3>2      :call SetTabIndentation(2)<enter>
inoremap <f3>4 <esc>:call SetTabIndentation(4)<enter>
nnoremap <f3>4      :call SetTabIndentation(4)<enter>
inoremap <f3>8 <esc>:call SetTabIndentation(8)<enter>
nnoremap <f3>8      :call SetTabIndentation(8)<enter>

" set list
" set listchars=tab:!.

au! WinEnter * call SetWinAdjust()

fun! SetWinAdjust()
	if winnr() > 1
		nnoremap <C-w>> 5<C-w><
		nnoremap <C-w>< 5<C-w>>
	else
		nnoremap <C-w>> 5<C-w>>
		nnoremap <C-w>< 5<C-w><
	endif
endfun

function PythonFmt()
	:let @a=line(".")
	:% !python3 -m isort -
	:% !python3 -m black -q -
	:@a
	echo('PythonFmt: ok')
endfunction
command PythonFmt :call PythonFmt()

function GoFmt()
	:let @a=line(".")
	:% !gofmt
	:@a
	echo('GoFmt: ok')
endfunction
command GoFmt :call GoFmt()

call plug#begin()

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()

" if filereadable("./.git/project.vim")
" 	:source ./.git/project.vim
" endif
" if filereadable("./project.vim")
" 	:source ./project.vim
" endif
" if filereadable("./scripts/editor.startup.vim")
" 	:source ./scripts/editor.startup.vim
" endif

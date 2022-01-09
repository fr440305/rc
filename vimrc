inoremap jk <esc>

set nofixeol

set number
set nocompatible
set history=1000
syntax on

set autoindent
" set smartindent
set noexpandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4

set ruler
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=green
set incsearch
set showmatch

set textwidth=75
" set colorcolumn=80

set lisp " including hyphenated words as key-words, useful when writing HTML classNames.

if has("multi_byte")
	set encoding=utf-8
	set termencoding=utf-8
	set formatoptions+=mM
	set fencs=utf-8,gbk
	if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
		set ambiwidth=double
	endif
endif

colorscheme koehler

nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-l> :Explore<CR>

let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
" let g:netrw_banner = 0
" let g:netrw_winsize = 25

filetype plugin indent on

inoremap {<CR> {<CR>}<esc>ko

autocmd BufNewFile *.html 0r ~/.vim/templates/html.template

highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhiteSpace /\s\+$/

function RemoveExtraWhiteSpaces()
	:mark `
	:%s/\s\+$//e
	:normal ``
endfunction

command RemoveExtraWhiteSpaces :call RemoveExtraWhiteSpaces()

if filereadable("./.git/project.vim")
	:source ./.git/project.vim
endif

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

inoremap <f3>4 <esc>:call SetTabIndentation(4)<enter>
nnoremap <f3>4      :call SetTabIndentation(4)<enter>
inoremap <f3>8 <esc>:call SetTabIndentation(8)<enter>
nnoremap <f3>8      :call SetTabIndentation(8)<enter>

" set list
" set listchars=tab:!.

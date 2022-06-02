"
" ~/.vimrc
"

filetype on
filetype plugin on
filetype indent on
set tabstop=4
set shiftwidth=0
set expandtab
set smarttab
set autoindent
set smartindent
set incsearch
set nocompatible
set number
set showcmd
set showmatch
set title
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
syntax enable

" PLUGINS --------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'https://github.com/vifm/vifm.vim.git'

call plug#end() 

" }}}

if has("autocmd")
          
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  endif

" TALK ------------------------------------------------------------------ {{{
" https://youtu.be/XA2WjJbmmoM ----------------------------------------------

" Finding files using :find <name>
set path+=**
" Also use :b to select files in buffer

" Show suggestions on another line instead of inplace
set wildmenu

" Tags
" pacman -S ctags
command! MakeTags !ctags -R . &
" Move to defintion using ^]
" Move to ambigious using g^]
" Move back using ^t

" Autocomplete
" Also see https://vimhelp.org/options.txt.html#%27complete%27
" ^n next
" ^p previous
" ^x^f filename completion


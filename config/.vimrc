"
" ~/.vimrc
"

filetype on
filetype plugin on
filetype indent on
set expandtab
set smarttab
set smartindent
set incsearch
set showmatch
set title
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
syntax enable

" --

set scrolloff=3
set showcmd

set autoindent
set linebreak
set shiftwidth=4
set tabstop=4

set number
set relativenumber

" colorscheme nord-light
set conceallevel=2

" Add mouse support
set mouse=a
if $TERM == 'alacritty'
    set ttymouse=sgr " Alacritty specific
endif

" PLUGINS --------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'https://github.com/vifm/vifm.vim.git'

call plug#end() 

" }}}

" AUTOMATIC STUFF ------------------------------------------------------- {{{

if has("autocmd")
          
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " https://stackoverflow.com/a/37558470/19044747
    augroup remember_folds
        autocmd!
        autocmd BufWinLeave * silent! mkview
        autocmd BufWinEnter * silent! loadview
    augroup END

endif

" }}}

" TALK ------------------------------------------------------------------ {{{
" https://youtu.be/XA2WjJbmmoM ----------------------------------------------

set nocompatible

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

" File browsing
let g:netrw_browse_split=4  " open in the previous window
let g:netrw_altv=1          " split new windows to the right
let g:netrw_liststyle=3     " treeview

" Autocomplete
" Also see https://vimhelp.org/options.txt.html#%27complete%27
" ^n next
" ^p previous
" ^x^f filename completion

" }}}

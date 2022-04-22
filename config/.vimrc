"
" ~/.vimrc
"

filetype on
filetype plugin on
filetype indent on
set expandtab
set incsearch
set number
set showmatch
set title
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
syntax on

" PLUGINS --------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'

call plug#end() 

" }}}

if has("autocmd")
          au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  endif


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
set number
set showmatch
set title
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
syntax on

" Automatically add closing parts
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap < <><Left>
inoremap ' ''<Left>
inoremap " ""<Left>

" PLUGINS --------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'

call plug#end() 

" }}}

if has("autocmd")
          au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  endif


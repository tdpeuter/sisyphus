"
" ~/.vimrc
"

colorscheme tdpeuter-light

set autoindent
set conceallevel=2
set expandtab
set incsearch
set linebreak
set mouse=a
set nocompatible
set number
set path+=**
set relativenumber
set scrolloff=3
set shiftwidth=4
set showcmd
set showmatch
set smartindent
set smarttab
set tabstop=4
set title
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
"" Show suggestions on another line instead of inplace
set wildmenu

syntax enable

filetype on
filetype indent on
filetype plugin on

" File browsing
let g:netrw_browse_split=4  " open in the previous window
let g:netrw_altv=1          " split new windows to the right
let g:netrw_liststyle=3     " treeview

" Autocomplete
" Also see https://vimhelp.org/options.txt.html#%27complete%27
" ^n next
" ^p previous
" ^x^f filename completion

if $TERM == 'alacritty'
    set ttymouse=sgr " Alacritty specific
endif
if $TERM == 'xterm-kitty'
    " Fix <HOME> and <END> not working
    set term=xterm-256color
endif

" AUTO ------------------------------------------------------------------ {{{

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

" PLUGINS --------------------------------------------------------------- {{{

call plug#begin()

Plug 'dense-analysis/ale'
Plug 'vifm/vifm.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'NerdyPepper/statix'

call plug#end() 

" }}}


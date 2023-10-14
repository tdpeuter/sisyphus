{ inputs, lib, config, pkgs, ... }:

{
    home-manager.users.tdpeuter = { pkgs, ... }: {
        home.file = {
            ".vim".source = ../../../../stow/vim/.vim;
        };

        programs.vim = {
            enable = true;
            extraConfig = ''
                colorscheme tdpeuter-light
                
                " Tags
                " pacman -S ctags
                command! MakeTags !ctags -R . &
                " Move to defintion using ^]
                " Move to ambigious using g^]
                " Move back using ^t
                
                filetype on
                filetype indent on
                filetype plugin on

                " File browsing
                let g:netrw_browse_split=4  " open in the previous window
                let g:netrw_altv=1          " split new windows to the right
                let g:netrw_liststyle=3     " treeview
                
                set autoindent
                set conceallevel=2
                set incsearch
                set linebreak
                set nocompatible
                set path+=**
                set scrolloff=3
                set showcmd
                set showmatch
                set smartindent
                set smarttab
                set title
                set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
                set wildmenu
                
                syntax enable
                
                if $TERM == 'alacritty'
                    set ttymouse=sgr " Alacritty specific
                endif
                if $TERM == 'xterm-kitty'
                    " Fix <HOME> and <END> not working
                    set term=xterm-256color
                endif

                if has("autocmd")
                    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
                    " https://stackoverflow.com/a/37558470/19044747
                    augroup remember_folds
                        autocmd!
                        autocmd BufWinLeave * silent! mkview
                        autocmd BufWinEnter * silent! loadview    
                    augroup END
                endif 
            '';
            plugins = with pkgs.vimPlugins; [
                ale
                catppuccin-vim
                statix
                vifm-vim
            ];
            settings = {
                expandtab = true;
                mouse = "a";
                number = true;
                relativenumber = true;
                shiftwidth = 4;
                tabstop = 4;
            };
        };
    };
}

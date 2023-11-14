{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;
  user = config.users.users.tdpeuter.name;
  installedPkgs = config.environment.systemPackages ++ config.home-manager.users.tdpeuter.home.packages;
in {
  config = lib.mkIf cfg.enable {
    home-manager.users.tdpeuter = lib.mkIf config.sisyphus.programs.home-manager.enable {
      home = {
        file = {
          ".config/alacritty" = lib.mkIf (builtins.elem pkgs.alacritty installedPkgs) {
            source = ../../../stow/alacritty/.config/alacritty;
          };
          ".config/dunst" = {
            enable = config.sisyphus.desktop.sway.enable;
            source = ../../../stow/dunst/.config/dunst;
          };
          ".config/fuzzel" = {
            enable = builtins.elem pkgs.fuzzel installedPkgs;
            source = ../../../stow/fuzzel/.config/fuzzel;
            recursive = true;
          };
          ".config/git" = {
            enable = (builtins.elem pkgs.git installedPkgs);
            source = ../../../stow/git/.config/git;
            recursive = true;
          };
          ".config/kitty" = {
            enable = builtins.elem pkgs.kitty installedPkgs;
            source = ../../../stow/kitty/.config/kitty;
            recursive = true;
          };
          ".config/mako" = {
            enable = builtins.elem pkgs.mako installedPkgs;
            source = ../../../stow/mako/.config/mako;
          };
          ".config/mpv" = {
            enable = (builtins.elem pkgs-unstable.mpv installedPkgs);
            source = ../../../stow/mpv/.config/mpv;
          };
          ".config/OpenRGB" = {
            enable = config.sisyphus.services.openrgb.enable;
            source = ../../../stow/openrgb/.config/OpenRGB;
            recursive = true;
          };
          ".config/vifm" = {
            enable = (builtins.elem pkgs.vifm installedPkgs);
            source = ../../../stow/vifm/.config/vifm;
            recursive = true; # Fix history and all working
          };
          ".config/waybar" = {
            enable = config.sisyphus.desktop.sway.enable;
            source = ../../../stow/waybar/.config/waybar;
          };
          ".config/zellij" = {
            enable = (builtins.elem pkgs.zellij installedPkgs);
            source = ../../../stow/zellij/.config/zellij;
          };
          ".oh-my-zsh" = {
            enable = (builtins.elem pkgs.zsh installedPkgs);
            source = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
            recursive = true;
          };
          ".oh-my-zsh/themes/tdpeuter.zsh-theme" = {
            enable = (builtins.elem pkgs.zsh installedPkgs);
            source = ../../../stow/zsh/.oh-my-zsh/themes/tdpeuter.zsh-theme;
          };
          ".ssh/config" = lib.mkIf config.sisyphus.programs.ssh.enable {
            source = ../../../stow/ssh/.ssh/config;
          };
          ".vim" = {
            enable = (builtins.elem pkgs.vim-full installedPkgs);
            source = ../../../stow/vim/.vim;
            recursive = true;
          };
          ".vim/autoload/plug.vim" = {
            enable = (builtins.elem pkgs.vim-full installedPkgs);
            source = "${pkgs.vimPlugins.vim-plug}/plug.vim";
          };
          ".vimrc" = {
            enable = (builtins.elem pkgs.vim-full installedPkgs);
            source = ../../../stow/vim/.vimrc;
          };
          ".zshrc" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = ../../../stow/zsh/.zshrc;
          };
          ".zsh/plugins/cmdtime/cmdtime.plugin.zsh" = {
            enable = (builtins.elem pkgs.cmdtime installedPkgs);
            source = "${pkgs.cmdtime}/share/cmdtime/cmdtime.plugin.zsh";
          };
          ".zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" = {
            enable = (builtins.elem pkgs.zsh-autosuggestions installedPkgs);
            source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
          };
          ".zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" = {
            enable = (builtins.elem pkgs.zsh-syntax-highlighting installedPkgs);
            source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
          };
        };
      };
    };
  };
}

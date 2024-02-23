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
          ".config/alacritty" = {
            source = ../../../stow/alacritty/.config/alacritty;
          };
          ".config/dunst" = {
            enable = config.sisyphus.desktop.sway.enable;
            source = ../../../stow/dunst/.config/dunst;
          };
          ".config/fuzzel" = {
            source = ../../../stow/fuzzel/.config/fuzzel;
            recursive = true;
          };
          ".config/git" = {
            source = ../../../stow/git/.config/git;
            recursive = true;
          };
          ".config/kitty" = {
            source = ../../../stow/kitty/.config/kitty;
            recursive = true;
          };
          ".config/mako" = {
            source = ../../../stow/mako/.config/mako;
          };
          ".config/mpv" = {
            source = ../../../stow/mpv/.config/mpv;
          };
          ".config/OpenRGB" = {
            enable = config.sisyphus.services.openrgb.enable;
            source = ../../../stow/openrgb/.config/OpenRGB;
            recursive = true;
          };
          ".config/sway" = {
            enable = config.sisyphus.desktop.sway.enable;
            source = ../../../stow/sway/.config/sway;
          };
          ".config/swayidle" = {
            enable = config.sisyphus.desktop.sway.enable;
            source = ../../../stow/swayidle/.config/swayidle;
          };
          ".config/swaylock" = {
            enable = config.sisyphus.desktop.sway.enable;
            source = ../../../stow/swaylock/.config/swaylock;
          };
          ".config/vifm" = {
            source = ../../../stow/vifm/.config/vifm;
            recursive = true; # Fix history and all working
          };
          ".config/waybar" = {
            enable = config.sisyphus.desktop.sway.enable;
            source = ../../../stow/waybar/.config/waybar;
          };
          ".config/zellij" = {
            source = ../../../stow/zellij/.config/zellij;
          };
          ".oh-my-zsh" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
            recursive = true;
          };
          ".oh-my-zsh/themes/tdpeuter.zsh-theme" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = ../../../stow/zsh/.oh-my-zsh/themes/tdpeuter.zsh-theme;
          };
          ".ssh/config" = lib.mkIf config.sisyphus.programs.ssh.enable {
            source = ../../../stow/ssh/.ssh/config;
          };
          ".vim" = {
            source = ../../../stow/vim/.vim;
            recursive = true;
          };
          ".vim/autoload/plug.vim" = {
            source = "${pkgs.vimPlugins.vim-plug}/plug.vim";
          };
          ".vimrc" = {
            source = ../../../stow/vim/.vimrc;
          };
          ".zshrc" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = ../../../stow/zsh/.zshrc;
          };
          ".zsh/plugins/cmdtime/cmdtime.plugin.zsh" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = "${pkgs.cmdtime}/share/cmdtime/cmdtime.plugin.zsh";
          };
          ".zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
          };
          ".zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
          };
        };
      };
    };
  };
}

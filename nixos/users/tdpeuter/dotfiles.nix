{ config, lib, pkgs, pkgs-unstable, ... }:

# Does basically the same thing that stow does, but using Nix.

let
  cfg = config.sisyphus.users.tdpeuter;
  user = config.users.users.tdpeuter.name;
  installedPkgs = config.environment.systemPackages ++ config.home-manager.users.tdpeuter.home.packages;
in {
  config = lib.mkIf cfg.enable {
    home-manager.users.tdpeuter = lib.mkIf config.sisyphus.programs.home-manager.enable {
      home = {
        file = lib.mkMerge [
          {
            ".config/alacritty" = {
              enable = false;
              source = ../../../stow/alacritty/.config/alacritty;
            };
            ".config/dunst" = {
              inherit (config.sisyphus.desktop.sway) enable;
              source = ../../../stow/dunst/.config/dunst;
            };
            ".config/foot" = {
              source = ../../../stow/foot/.config/foot;
            };
            ".config/fuzzel" = {
              recursive = true;
              source = ../../../stow/fuzzel/.config/fuzzel;
            };
            ".config/git" = {
              recursive = true;
              source = ../../../stow/git/.config/git;
            };
            ".config/kitty" = {
              enable = false;
              recursive = true;
              source = ../../../stow/kitty/.config/kitty;
            };
            ".config/mako" = {
              enable = false;
              source = ../../../stow/mako/.config/mako;
            };
            ".config/mpv" = {
              source = ../../../stow/mpv/.config/mpv;
            };
            ".config/OpenRGB" = {
              inherit (config.sisyphus.services.openrgb) enable;
              recursive = true;
              source = ../../../stow/openrgb/.config/OpenRGB;
            };
            ".config/sway" = {
              inherit (config.sisyphus.desktop.sway) enable;
              source = ../../../stow/sway/.config/sway;
            };
            ".config/swayidle" = {
              inherit (config.sisyphus.desktop.sway) enable;
              source = ../../../stow/swayidle/.config/swayidle;
            };
            ".config/swaylock" = {
              inherit (config.sisyphus.desktop.sway) enable;
              source = ../../../stow/swaylock/.config/swaylock;
            };
            ".config/vifm" = {
              recursive = true; # Fix history and all working
              source = ../../../stow/vifm/.config/vifm;
            };
            ".config/waybar" = {
              inherit (config.sisyphus.desktop.sway) enable;
              source = ../../../stow/waybar/.config/waybar;
            };
            ".config/zellij" = {
              source = ../../../stow/zellij/.config/zellij;
            };
            ".oh-my-zsh" = {
              enable = config.users.users.tdpeuter.shell == pkgs.zsh;
              source = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
              recursive = true;
            };
            ".oh-my-zsh/themes/tdpeuter.zsh-theme" = {
              enable = config.users.users.tdpeuter.shell == pkgs.zsh;
              source = ../../../stow/zsh/.oh-my-zsh/themes/tdpeuter.zsh-theme;
            };
            ".ssh/config" = lib.mkIf config.sisyphus.programs.ssh.enable {
              inherit (config.sisyphus.programs.ssh) enable;
              source = ../../../stow/ssh/.ssh/config;
            };
            ".vim" = {
              recursive = true;
              source = ../../../stow/vim/.vim;
            };
            ".vim/autoload/plug.vim" = {
              source = "${pkgs.vimPlugins.vim-plug}/plug.vim";
            };
            ".vimrc" = {
              source = ../../../stow/vim/.vimrc;
            };
          }
          (lib.mkIf (config.users.users.tdpeuter.shell == pkgs.zsh) {
            ".zshrc" = {
              source = ../../../stow/zsh/.zshrc;
            };
            ".zsh/plugins/cmdtime/cmdtime.plugin.zsh" = {
              source = "${pkgs.cmdtime}/share/cmdtime/cmdtime.plugin.zsh";
            };
            ".zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" = {
              source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            };
            ".zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" = {
              source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
            };
          })
        ];
      };
    };
  };
}

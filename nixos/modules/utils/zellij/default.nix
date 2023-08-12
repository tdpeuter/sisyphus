{ config, pkgs, lib, ... }:

{
  home-manager.users.tdpeuter.home = {
    packages = with pkgs; [
      zellij
    ];

    file.".config/zellij".source = ../../../../stow/zellij/.config/zellij;
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
  ];
}

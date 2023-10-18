{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.zellij;
in {
  options.sisyphus.programs.zellij.enable = lib.mkEnableOption "Zellij";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zellij
    ];

    fonts.fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
    ];
  };
}

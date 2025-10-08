{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.desktop.waybar;
in {
  options.sisyphus.desktop.waybar.enable = lib.mkEnableOption "Waybar";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libnotify
      playerctl
      jq
      j4-dmenu-desktop
    ];

    programs.waybar.enable = true;
  };
}

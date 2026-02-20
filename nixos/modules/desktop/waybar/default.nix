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

    fonts.packages = with pkgs; [
      font-awesome_6
    ];

    programs.waybar.enable = true;

    services.atd.enable = true; # Command scheduler
  };
}

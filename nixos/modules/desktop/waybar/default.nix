{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.desktop.waybar;
in {
  options.sisyphus.desktop.waybar.enable = lib.mkEnableOption "Waybar";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jq               # JSON parser
      libnotify        # Notifications
      sunwait          # Sunrise/sunset calculator

      playerctl
      j4-dmenu-desktop
    ];

    programs.waybar.enable = true;
  };
}

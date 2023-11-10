{ config, lib, pkgs, ... }:

# This module is not tested at all so it might be broken!

let
  cfg = config.sisyphus.desktop.plasma;
in {
  options.sisyphus.desktop.plasma.enable = lib.mkEnableOption "KDE Plasma";

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager = {
        defaultSession = "plasmawayland";
        sddm = {
          enable = true;
          # https://discourse.nixos.org/t/plasma-wayland-session-not-available-from-sddm/13447/2
          settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
        };
      };
      
      desktopManager.plasma5 = {
        enable = true;
        useQtScaling = true;
      };
      
      excludePackages = with pkgs; [
        xterm
      ];
    };

    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      elisa
      okular
      khelpcenter
      konsole
      print-manager
      plasma-systemmonitor
      gwenview
    ];
  };
}

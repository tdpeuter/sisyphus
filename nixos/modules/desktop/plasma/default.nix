{ config, lib, pkgs, ... }:

# This module is not tested at all so it might be broken!

let
  cfg = config.sisyphus.desktop.plasma;
in {
  options.sisyphus.desktop.plasma.enable = lib.mkEnableOption "KDE Plasma";

  config = lib.mkIf cfg.enable {
    services = {
      displayManager = {
        defaultSession = "plasma";
        sddm = {
          enable = true;
          wayland.enable = true;
          # https://discourse.nixos.org/t/plasma-wayland-session-not-available-from-sddm/13447/2
          # settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
        };
      };
      
      desktopManager.plasma6.enable = true;

      # Use gnome keyring instead of KDE Wallet.
      gnome.gnome-keyring.enable = true;

      xserver = {
        enable = true;
        excludePackages = with pkgs; [
          xterm
        ];
        videoDrivers = [ "nvidia" ];
      };
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      gwenview
      kate
      khelpcenter
      konsole
      kwalletmanager
      okular
      plasma-systemmonitor
      print-manager
    ];
  };
}

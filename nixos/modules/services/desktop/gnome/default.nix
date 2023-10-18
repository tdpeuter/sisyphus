{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.desktop.gnome;
in {
  options.sisyphus.services.desktop.gnome.enable = lib.mkEnableOption "GNOME";

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Start a new instance of application instead of going to that window.
    environment.systemPackages = with pkgs.gnomeExtensions; [
      launch-new-instance
    ];

    # Do not use these packages
    environment.gnome.excludePackages = (with pkgs; [
      baobab
      epiphany          # Web browser
      evince            # Document viewer
      gnome-connections # Remote desktop client
      gnome-console
      gnome-photos
      gnome-text-editor
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      eog               # Image viewer
      file-roller       # Archive manager
      geary             # Mail client
      gedit
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-disk-utility
      gnome-maps
      gnome-music
      gnome-system-monitor
      gnome-weather
      simple-scan
      totem             # Movie player
      yelp              # Help viewer
    ]);
  };
}

{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    
    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    excludePackages = with pkgs; [
      xterm
    ];
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.launch-new-instance
  ];

  # We do not want these packages automatically
  environment.gnome.excludePackages = (with pkgs; [
    baobab
    epiphany # Web browser
    evince # Document viewer
    gnome-connections # Remote desktop client
    gnome-console
    gnome-photos
    gnome-text-editor
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    eog # Image viewer
    file-roller # Archive manager
    geary # Mail client
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
    totem # Movie player
    yelp # Help viewer
  ]);
}

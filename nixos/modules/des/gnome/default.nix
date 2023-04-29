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

  environment.gnome.excludePackages = (with pkgs; [
    epiphany # Web browser
    gnome-console
    gnome-photos
    gnome-text-editor
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    geary # Mail client
    gedit
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-weather
    simple-scan
    totem # Movie player
    yelp # Help viewer
  ]);
}

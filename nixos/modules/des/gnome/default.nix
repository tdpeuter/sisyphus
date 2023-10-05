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

  # GNOME ricing
  # Browse available settings by running:
  # gsettings list-schemas | xargs -I % sh -c 'echo %; gsettings list-keys %' | less
  home-manager.users.tdpeuter.dconf.settings = {
    "org/gnome/desktop/interface" = {
      enable-animations = false;
    };
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/peripherals.touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = false;
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    # TODO Add background
    # "org/gnome/desktop/background"
  };
}

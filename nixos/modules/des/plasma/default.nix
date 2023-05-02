{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager.sddm = {
      enable = true;
      # https://discourse.nixos.org/t/plasma-wayland-session-not-available-from-sddm/13447/2
      settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
    };
    
    desktopManager.plasma5 = {
      enable = true;
      useQtScaling = true;

      excludePackages = with pkgs.libsForQt5; [
        elisa
        okular
        khelpcenter
        konsole
        print-manager
        plasma-systemmonitor
        gwenview
      ];
    };
    
    excludePackages = with pkgs; [
      xterm
    ];
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.desktop.gnome;
in {
  options.sisyphus.desktop.gnome.enable = lib.mkEnableOption "GNOME";

  config = lib.mkIf cfg.enable {
    services = {
      gnome = {
        core-apps.enable = false;
        core-developer-tools.enable = false;
        core-shell.enable = true;
      };

      xserver = {
        enable = true;

        excludePackages = with pkgs; [
          xterm
        ];

        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        videoDrivers = [ "nvidia" ];
      };
    };

    # Start a new instance of application instead of going to that window.
    environment.systemPackages = with pkgs.gnomeExtensions; [
      launch-new-instance
    ];
  };
}

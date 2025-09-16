{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.desktop.hyprland;
in {
  options.sisyphus.desktop.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf cfg.enable {
    environment = {
      sessionVariables = {
        # Hint Electron apps to use wayland
        NIXOS_OZONE_WL = "1";

        SCRIPT_DIR = ../../../../scripts;
      };

      systemPackages = with pkgs; [
        brightnessctl
        dunst
        libnotify
        swaybg
        waybar
        waycorner
        wlsunset
        wl-clipboard # Copying to system clipboard in vim

        glib

        libva

        dmenu
        jq
        j4-dmenu-desktop
        rofi
      ];
    };

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      waybar.enable = true;
    };

    services = {
      displayManager.ly.enable = true;
      gnome.gnome-keyring.enable = true;
      power-profiles-daemon.enable = true;
      xserver.videoDrivers = [ "nvidia" ];
    };
  };
}


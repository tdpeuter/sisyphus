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

        ASSETS_DIR = ../../../../assets;
        SCRIPT_DIR = ../../../../scripts;
      };

      systemPackages = with pkgs; [
        brightnessctl
        dunst
        libnotify
        swaybg
        waycorner
        playerctl
        wlsunset
        wl-clipboard # Copying to system clipboard in vim
        wl-mirror # Mirror an output
        wdisplays # Tool to configure displays

        swaylock

        glib

        libva

        dmenu
        jq
        j4-dmenu-desktop
        rofi
      ];
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    security.polkit.enable = true;

    services = {
      dbus.enable = true;
      displayManager.ly.enable = true;
      gnome.gnome-keyring.enable = true;
      xserver.videoDrivers = [ "nvidia" ];
    };

    sisyphus.desktop.waybar.enable = true;
  };
}


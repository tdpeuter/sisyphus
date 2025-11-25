{ config, lib, pkgs, pkgs-unstable, system, ... }:

let
  cfg = config.sisyphus.desktop.hyprland;

  inherit (pkgs-unstable.hyprlandPlugins.hy3) version;

  # Make hyprland package follow latest release of Hy3
  hyprland = pkgs-unstable.hyprland.overrideAttrs (old: {
    version = "0.52.0";
    src = pkgs-unstable.fetchFromGitHub {
      owner = "hyprwm";
      repo = "Hyprland";
      fetchSubmodules = true;
      rev = "f56ec180d3a03a5aa978391249ff8f40f949fb73";
      hash = "sha256-aZCTbfKkxsEinY5V7R0NYuuitKLYc8ig8T91+yDMGJ0=";
    };
  });

  hy3 = pkgs-unstable.hyprlandPlugins.hy3.overrideAttrs (old: {
    version = "hl0.52.0";
    src = pkgs-unstable.fetchFromGitHub {
      owner = "outfoxxed";
      repo = "hy3";
      rev = "16dae4d8f853b0d3e8434ee9941f9fc0155b8952";
      hash = "sha256-UeMEUlQsil5DEtF/VQ//41vXJF9ff2xjoYVjhR6dqu4=";
    };
  });
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

      systemPackages = (with pkgs; [
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
      ]) ++ [
        hy3 # i3/sway layout plugin
      ];
    };

    programs.hyprland = {
      enable = true;
      package = hyprland;
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


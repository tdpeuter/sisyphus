{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.desktop.sway;

  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      # gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };
in {
  options.sisyphus.desktop.sway.enable = lib.mkEnableOption "Sway";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = (with pkgs; [
      dbus-sway-environment
      configure-gtk
      wayland
      xdg-utils # Open with default program
      glib      # gsettings
      wl-clipboard
      wdisplays # Tool to configure displays

      brightnessctl
      dunst
      libnotify
      playerctl
      swaybg
      swaylock-effects
      waybar
      wlsunset

      # TODO Turn into own module/package?
      jq
      j4-dmenu-desktop
      rofi
    ]) ++ (with pkgs.sway-contrib; [
      grimshot
    ]);

    environment.sessionVariables = {
      SCRIPT_DIR = ../../../../scripts;
    };

    fonts.packages = with pkgs; [
      dejavu_fonts
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];

    security.polkit.enable = true;
  
    services = {
      atd.enable = true; # Required by sunset.sh
      dbus.enable = true;
      gnome.gnome-keyring.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };

      power-profiles-daemon.enable = true;

      xserver.displayManager.session = [{
        manage = "window";
        name = "Sway";
        start = ''
          ${pkgs.sway}/bin/sway --unsupported-gpu &
          waitPID=$!
        '';
      }];    
    };
    
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    sisyphus.users.wantedGroups = [
      config.users.groups.video.name # Brightnessctl
    ];
  };
}

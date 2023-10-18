{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;

  installedPkgs = config.home-manager.users.tdpeuter.home.packages;
in {
  options.sisyphus.users.tdpeuter.enable = lib.mkEnableOption "user Tibo De Peuter";

  config = lib.mkIf cfg.enable {
    users.users.tdpeuter = {
      description = "Tibo De Peuter";
      isNormalUser = true;
      extraGroups = [ 
        config.users.groups.keys.name
        config.users.groups.networkmanager.name
        config.users.groups.wheel.name
      ];
      initialPassword = "ChangeMe";
    };

    home-manager.users.tdpeuter = lib.mkIf config.sisyphus.programs.home-manager.enable {
      programs.home-manager.enable = true;

      home = {
        username = "tdpeuter";
        homeDirectory = "/home/tdpeuter";
        stateVersion = config.system.stateVersion;

        # If you specify an application here, it will be detected by the configuration module
        #  and the configuration files will be put in place for you.
        packages = (with pkgs; [
          duf
          jellyfin-media-player
          libreoffice-fresh
          nextcloud-client
          nsxiv
          obsidian
          qalculate-gtk
          spotify
          unzip
          zathura
        ]) ++ (with pkgs-unstable; [
          mpv
        ]);

        # Put dotfiles in place.
        file = {
          ".config/alacritty" = lib.mkIf (builtins.elem pkgs.alacritty installedPkgs) {
            source = ../../../../stow/alacritty/.config/alacritty;
          };
          ".config/mpv" = lib.mkIf (builtins.elem pkgs-unstable.mpv installedPkgs) {
            source = ../../../../stow/mpv/.config/mpv;
          };
          ".config/zellij" = lib.mkIf (builtins.elem pkgs.zellij installedPkgs) {
            source = ../../../../stow/zellij/.config/zellij;
          };
        };
      };

      xdg.mimeApps = {
        enable = true;

        defaultApplications = let
          browser = "firefox.desktop";
          image-viewer = "nsxiv.desktop";
          pdf-viewer = "org.pwmt.zathura-pdf-mupdf.desktop";
        in {
          "application/pdf" = pdf-viewer;
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/x-extension-xht" = browser;
          "application/x-extension-xhtml" = browser;
          "application/xhtml+xml" = browser;
          "image/jpeg" = image-viewer;
          "image/png" = image-viewer;
          "image/webp" = image-viewer;
          "text/html" = browser;
          "x-scheme-handler/chrome" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
        };
      };
    };
  };
}

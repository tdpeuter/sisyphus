{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;

  installedPkgs = config.environment.systemPackages ++ config.home-manager.users.tdpeuter.home.packages;
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

        fonts.fonts = with pkgs; [
          font-awesome_5        # Dependency of Vifm config
        ];

        # If you specify an application here, it will be detected by the configuration module
        #  and the configuration files will be put in place for you.
        packages = (with pkgs; [
          chafa                 # Terminal image viewer
          duf                   # Df alternative
          glow                  # Terminal Markdown renderer
          jellyfin-media-player
          libreoffice-fresh
          nextcloud-client
          nsxiv                 # Lightweight image viewer
          obsidian
          qalculate-gtk         # Calculator
          spotify
          unzip
          vifm                  # File manager
          zathura               # PDF viewer
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

          # Put Vifm files separately so history fill still works.
          ".config/vifm/colors" = lib.mkIf (builtins.elem pkgs.vifm installedPkgs) {
            source = ../../../../stow/vifm/.config/vifm/colors;
          };
          ".config/vifm/scripts" = lib.mkIf (builtins.elem pkgs.vifm installedPkgs) {
            source = ../../../../stow/vifm/.config/vifm/scripts;
          };
          ".config/vifm/vifmrc" = lib.mkIf (builtins.elem pkgs.vifm installedPkgs) {
            source = ../../../../stow/vifm/.config/vifm/vifmrc;
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

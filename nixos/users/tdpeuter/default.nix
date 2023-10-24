{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;

  user = config.users.users.tdpeuter.name;
  installedPkgs = config.environment.systemPackages ++ config.home-manager.users.tdpeuter.home.packages;
in {
  imports = [
    ./dotfiles.nix
    ./firefox.nix  # Enables Firefox without setting options
    ./mail.nix     # Enables Thunderbird without setting options
    ./secrets.nix
  ];

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
      shell = pkgs.zsh;
    };

    fonts.fonts = with pkgs; [
      corefonts             # Calibri for Uni
      font-awesome_5        # Dependency of Vifm config
      font-awesome          # Dependency of zsh
      letter                # Personal font
      noto-fonts-cjk        # Dependency of Zellij config
      noto-fonts            # Dependency of Zellij config
      vistafonts            # Microsoft fonts
    ];

    sisyphus.programs.spotify-adblock.enable = true;

    home-manager.users.tdpeuter = lib.mkIf config.sisyphus.programs.home-manager.enable {
      programs.home-manager.enable = true;

      home = {
        username = user;
        homeDirectory = "/home/${user}";
        inherit (config.system) stateVersion;

        # If you specify an application here, it will be detected by the configuration module
        #  and the configuration files will be put in place for you.
        packages = (with pkgs; [
          chafa                 # Terminal image viewer
          cmdtime               # Zsh plugin
          duf                   # Df alternative
          fzf
          glow                  # Terminal Markdown renderer
          icosystem             # Personal icon theme
          jellyfin-media-player
          kitty
          libreoffice-fresh
          nextcloud-client
          nsxiv                 # Lightweight image viewer
          oh-my-zsh
          qalculate-gtk         # Calculator
          tea                   # Gitea CLI
          unzip
          vifm                  # File manager
          zathura               # PDF viewer
          zellij                # Tmux + screen alternative
          zsh
          zsh-autosuggestions
          zsh-syntax-highlighting
        ]) ++ (with pkgs-unstable; [
          mpv
          obsidian
          spotify
        ]) ++ (with pkgs.vimPlugins; [
          statix
          vim-plug
        ]);
      };

      # GNOME ricing
      # Browse available settings by running:
      # gsettings list-schemas | xargs -I % sh -c 'echo %; gsettings list-keys %' | less
      dconf.settings = lib.mkIf config.sisyphus.services.desktop.gnome.enable {
        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/tdpeuter/Nextcloud/Afbeeldingen/wallpapers/bg";
          picture-uri-dark = "file:///home/tdpeuter/Nextcloud/Afbeeldingen/wallpapers/bg-dark";
        };
        "org/gnome/desktop/interface" = {
          enable-animations = false;
          enable-hot-corners = false;
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

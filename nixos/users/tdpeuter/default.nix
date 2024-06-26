{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;

  user = config.users.users.tdpeuter.name;
  installedPkgs = config.environment.systemPackages ++ config.home-manager.users.tdpeuter.home.packages;

  cursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    size = 24;
  };
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
      extraGroups = config.sisyphus.users.wantedGroups ++ [
        config.users.groups.input.name
        config.users.groups.keys.name
        config.users.groups.networkmanager.name
        config.users.groups.wheel.name
      ];
      initialPassword = "ChangeMe";
      shell = pkgs.zsh;
    };

    fonts.packages = with pkgs; [
      corefonts             # Calibri for Uni
      font-awesome          # Dependency of Vifm & zsh config
      letter                # Personal font
      noto-fonts-cjk        # Dependency of Zellij config
      noto-fonts            # Dependency of Zellij config
      vistafonts            # Microsoft fonts
    ];

    sisyphus = {
      programs.spotify-adblock.enable = true;
    };

    home-manager.users.tdpeuter = lib.mkIf config.sisyphus.programs.home-manager.enable {
      programs.home-manager.enable = true;

      home = {
        username = user;
        homeDirectory = "/home/${user}";
        inherit (config.system) stateVersion;

        packages = (with pkgs; [
          cmdtime               # Zsh plugin
          icosystem             # Personal icon theme
          spotify-adblock
        ]) ++ (with pkgs-unstable; [
          brave
          chafa                 # Terminal image viewer
          duf                   # Df alternative
          foot
          fzf
          glow                  # Terminal Markdown renderer
          jellyfin-media-player
          kitty
          libreoffice-fresh
          logseq
          mpv
          nextcloud-client
          nsxiv                 # Lightweight image viewer
          qalculate-gtk         # Calculator
          spotify
          unzip
          vifm                  # File manager
          zathura               # PDF viewer
          zellij                # Tmux + screen alternative
          zsh
          zsh-autosuggestions
          zsh-syntax-highlighting

          # SMB
          cifs-utils psmisc

          # Linters and LSPs
          statix      # Nix
          ruff pylint # Python
        ]);

        pointerCursor = {
          inherit (cursor) package name size;
          gtk.enable = true;
          x11.enable = true;
        };
      };

      # GNOME ricing
      # Browse available settings by running:
      # gsettings list-schemas | xargs -I % sh -c 'echo %; gsettings list-keys %' | less
      dconf.settings = lib.mkIf config.sisyphus.desktop.gnome.enable {
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

      gtk = {
        enable = true;
        cursorTheme = cursor;
      };

      xdg = {
        desktopEntries.spotify = {
          name = "Spotify";
          genericName = "Music Player";
          icon = "spotify-client";
          exec = "env LD_PRELOAD=${pkgs.spotify-adblock}/lib/libspotifyadblock.so spotify %U";
          mimeType = [ "x-scheme-handler/spotify" ];
          categories = [ "Audio" "Music" "Player" "AudioVideo" ];
          settings = {
            TryExec = "spotify";
            StartupWMClass = "spotify";
          };
        };
        mimeApps = {
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
  };
}

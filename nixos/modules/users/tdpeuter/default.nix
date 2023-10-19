{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;

  user = config.users.users.tdpeuter.name;
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
      shell = pkgs.zsh;
    };

    fonts.fonts = with pkgs; [
      font-awesome          # Dependency of zsh
      font-awesome_5        # Dependency of Vifm config
      noto-fonts            # Dependency of Zellij config
      noto-fonts-cjk        # Dependency of Zellij config
    ];

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
          jellyfin-media-player
          kitty
          libreoffice-fresh
          nextcloud-client
          nsxiv                 # Lightweight image viewer
          obsidian
          qalculate-gtk         # Calculator
          spotify
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
        ]) ++ (with pkgs.vimPlugins; [
          statix
          vim-plug
        ]);

        # Put dotfiles in place.
        file = {
          ".config/alacritty" = lib.mkIf (builtins.elem pkgs.alacritty installedPkgs) {
            source = ../../../../stow/alacritty/.config/alacritty;
          };
          ".config/git" = {
            enable = (builtins.elem pkgs.git installedPkgs);
            source = ../../../../stow/git/.config/git;
            recursive = true;
          };
          ".config/kitty" = {
            enable = builtins.elem pkgs.kitty installedPkgs;
            source = ../../../../stow/kitty/.config/kitty;
            recursive = true;
          };
          ".config/mpv" = {
            enable = (builtins.elem pkgs-unstable.mpv installedPkgs);
            source = ../../../../stow/mpv/.config/mpv;
          };
          ".ssh/config" = lib.mkIf config.sisyphus.programs.ssh.enable {
            source = ../../../../stow/ssh/.ssh/config;
          };
          ".config/vifm" = {
            enable = (builtins.elem pkgs.vifm installedPkgs);
            source = ../../../../stow/vifm/.config/vifm;
            recursive = true;
          };
          ".config/zellij" = {
            enable = (builtins.elem pkgs.zellij installedPkgs);
            source = ../../../../stow/zellij/.config/zellij;
          };
          ".oh-my-zsh" = {
            enable = (builtins.elem pkgs.zsh installedPkgs);
            source = ../../../../stow/zsh/.oh-my-zsh;
          };
          ".vim" = {
            enable = (builtins.elem pkgs.vim installedPkgs);
            source = ../../../../stow/vim/.vim;
            recursive = true;
          };
          ".vim/autoload/plug.vim" = {
            enable = (builtins.elem pkgs.vim installedPkgs);
            source = "${pkgs.vimPlugins.vim-plug}/plug.vim";
          };
          ".vimrc" = {
            enable = (builtins.elem pkgs.vim installedPkgs);
            source = ../../../../stow/vim/.vimrc;
          };
          ".zshrc" = {
            enable = (config.users.users.tdpeuter.shell == pkgs.zsh);
            source = ../../../../stow/zsh/.zshrc;
          };
          ".zsh/plugins/cmdtime/cmdtime.plugin.zsh" = {
            enable = (builtins.elem pkgs.cmdtime installedPkgs);
            source = "${pkgs.cmdtime}/share/cmdtime/cmdtime.plugin.zsh";
          };
          ".zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" = {
            enable = (builtins.elem pkgs.zsh-autosuggestions installedPkgs);
            source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";
          };
          ".zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" = {
            enable = (builtins.elem pkgs.zsh-syntax-highlighting installedPkgs);
            source = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
          };
        };
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
    sops.secrets = lib.mkIf config.sisyphus.programs.sops.enable (
      let
        Hugo = {
          format = "yaml";
          sopsFile = ../../../secrets/Hugo.yaml;
          owner = user;
        };
        UGent = {
          format = "yaml";
          sopsFile = ../../../secrets/UGent.yaml;
          owner = user;
        };
      in {
        "Hugo/ssh" = Hugo;
        "UGent/HPC/ssh" = UGent;

        "GitHub/ssh" = {
          format = "yaml";
          sopsFile = ../../../secrets/GitHub.yaml;
          owner = user;
        };
        "Hugo/Gitea/ssh" = Hugo;
        "UGent/GitHub/ssh" = UGent;
        "UGent/SubGit/ssh" = UGent;
      });
  };
}

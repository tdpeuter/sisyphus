{ inputs, lib, config, pkgs, ... }:

{
  # Check documentation at
  # https://rycee.gitlab.io/home-manager/options.html

  imports = [
  ];

  # Home manager
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tdpeuter";
    homeDirectory = "/home/tdpeuter";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";
  
    packages = with pkgs; [
      alacritty
      discord
      duf
      git-crypt
      gnupg
      libreoffice-fresh-unwrapped
      lynx
      mattermost-desktop
      nextcloud-client
      pinentry_qt
      spotify
      vifm
      vim
      w3m
      zathura
      zellij
      zenith
      zoom-us

      # Webdevelopment
      jetbrains.webstorm

      # Software Engineering Lab 1
      android-studio

      # Fonts
      font-awesome_5 # Vifm and zsh dependency
    ];

    file = {
      ".config/alacritty".source = ../../../stow/alacritty/.config/alacritty;
      ".config/vifm".source = ../../../stow/vifm/.config/vifm;
      ".vim".source = ../../../stow/vim/.vim;
      ".vimrc".source = ../../../stow/vim/.vimrc;
      ".config/zellij".source = ../../../stow/zellij/.config/zellij;
      ".oh-my-zsh".source = ../../../stow/zsh/.oh-my-zsh;
    };

  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "tdpeuter";
      userEmail = "tibo.depeuter@gmail.com";
      extraConfig = {
        core.editor = "vim";
      };
    };

    gpg.enable = true;

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        custom = "$HOME/.oh-my-zsh";
        plugins = [ "dirhistory" "git" "screen" ];
        theme = "mrfortem";
      };
      plugins = [
        {
          name = "cmdtime";
          src = pkgs.fetchFromGitHub {
            owner  = "tom-auger";
            repo   = "cmdtime";
            rev    = "ffc72641dcfa0ee6666ceb1dc712b61be30a1e8b";
            hash = "sha256-v6wCfNoPXDD3sS6yUYE6lre8Ir1yJcLGoAW3O8sUOCg=";
          };
        }
      ];
    };
  };


  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
    };

  };

}

{ inputs, lib, config, pkgs, ... }:

{
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
      duf
      git-crypt
      gnupg
      libreoffice-fresh-unwrapped
      lynx
      w3m
      nextcloud-client
      pinentry_qt
      vifm
      zathura
      zellij
      zenith
      
      # Webdevelopment
      jetbrains.webstorm
      nodejs
      nodePackages_latest.npm
      mongodb-6_0
      mongosh
      mongodb-tools
      mongodb-compass

      # Multimedia
      jetbrains.pycharm-professional
      python39
      python39Packages.pip
      gcc
      cmake

      # Software Engineering Lab 1
      android-studio
    ];

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
  };


  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "qt";
    };

  };

}

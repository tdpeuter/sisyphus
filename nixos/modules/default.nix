{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./apps
    ./shells
    ./utils
  ];
  
  # Nix Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  users.users.tdpeuter = {
    description = "Tibo De Peuter";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "ChangeMe";
    packages = with pkgs; [
      home-manager
    ];
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;

  home-manager.users.tdpeuter = { pkgs, ... }: {
    home = {
      username = "tdpeuter";
      homeDirectory = "/home/tdpeuter";
      stateVersion = "22.11";

      packages = with pkgs; [
        brave
        caprine-bin
        direnv
        discord
        duf
        git-crypt
        gnupg
        jellyfin-media-player
        libreoffice-fresh-unwrapped
        lynx
        mattermost-desktop
        nextcloud-client
        obsidian
        pinentry_qt
        spotify
        w3m
        zathura
        zenith
        zoom-us
        
        # Fonts
        corefonts      # Calibri for Uni
      ];
    };

    programs = {
      home-manager.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      git = {
        enable = true;
        userName = "tdpeuter";
        userEmail = "tibo.depeuter@gmail.com";
        extraConfig = {
          core.editor = "vim";
        };
        includes = [
          {
            path = "~/.gitconfig-ugent";
            condition = "gitdir:~/Nextcloud/Documenten/UGent";
          }
        ];
      };

      gpg.enable = true;

    };

    services = {
      gpg-agent = {
        enable = true;
        pinentryFlavor = "qt";
      };

    };
  };

}

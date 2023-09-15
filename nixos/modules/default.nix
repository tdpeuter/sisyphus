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
    extraGroups = [ 
      config.users.groups.keys.name
      config.users.groups.networkmanager.name
      config.users.groups.wheel.name
    ];
    initialPassword = "ChangeMe";
    packages = with pkgs; [
      home-manager
    ];
  };

  home-manager.useGlobalPkgs = true;

  home-manager.users.tdpeuter = { pkgs, ... }: {
    home = {
      username = "tdpeuter";
      homeDirectory = "/home/tdpeuter";
      stateVersion = "23.05";

      packages = with pkgs; [
        gnupg
        
        # Fonts
        corefonts      # Calibri for Uni
      ];
    };

    programs = {
      home-manager.enable = true;
      gpg.enable = true;
    };

    services = {
      gpg-agent = {
        enable = true;
        pinentryFlavor = "qt";
      };

    };

    xdg.mimeApps =
      let
        browser = "firefox.desktop";
        image-viewer = "nsxiv.desktop";
      in {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/chrome" = browser;
        "text/html" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/xhtml+xml" = browser;
        "application/x-extension-xhtml" = browser;
        "application/x-extension-xht" = browser;
        "image/jpeg" = image-viewer;
        "image/png" = image-viewer;
      };
    };
  };

}

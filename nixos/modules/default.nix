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

  fonts.fonts = with pkgs; [
    corefonts      # Calibri for Uni
    letter         # Personal font
  ];

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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  home-manager.useGlobalPkgs = true;

  home-manager.users.tdpeuter = { pkgs, ... }: {
    home = {
      username = "tdpeuter";
      homeDirectory = "/home/tdpeuter";
      stateVersion = "23.05";

      packages = with pkgs; [
        gnupg  
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
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
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

}

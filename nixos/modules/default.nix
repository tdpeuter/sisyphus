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
  };

}

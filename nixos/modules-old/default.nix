{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./apps
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
    vistafonts

    letter         # Personal font
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
}

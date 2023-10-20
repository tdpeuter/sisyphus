{ inputs, lib, config, pkgs, ... }:

{
  nix = {
    # Allow Nix Flakes
    # Keep derivations so shells don't break (direnv)
    # If the disk has less than 100MiB, free up to 2GiB by garbage-collecting.
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (2048 * 1024 * 1024)}
    '';
    # Scheduled garbage-collect
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixFlakes;
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
}

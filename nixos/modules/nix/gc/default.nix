{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.nix.gc;
in {
  options.sisyphus.nix.gc = {
    weekly.enable = lib.mkEnableOption "Scheduled Nix garbage-collection";
    onFull.enable = lib.mkEnableOption "Nix garbage-collection when disk is almost full";
  };

  config.nix = {
    # If the disk has less than 100MiB, free up to 2GiB by garbage-collecting.
    extraOptions = lib.mkIf cfg.onFull.enable ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (2048 * 1024 * 1024)}
    '';

    # Scheduled garbage-collect
    gc = lib.mkIf cfg.weekly.enable {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}

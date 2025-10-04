{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.sops;
in {
  options.sisyphus.programs.sops.enable = lib.mkEnableOption "Sops";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sops
    ];

    sops = {
      # Add secrets.yml to the Nix Store.
      defaultSopsFile = ../../../secrets/secrets.yaml;
      age = {
        # Don't derive age keys from SSH keys.
        sshKeyPaths = [ ];
        # Use an age key that is expected to already be in the filesystem.
        # You will need to place this file manually.
        keyFile = "/var/lib/sops-nix/key.txt";
      };
    };
  };
}

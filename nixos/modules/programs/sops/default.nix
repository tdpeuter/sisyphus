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
        # Automatically import SSH keys as age keys.
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        # Use an age key that is expected to already be in the filesystem.
        # You will need to place this file manually.
        keyFile = "/var/lib/sops-nix/key.txt";
      };
    };
  };
}

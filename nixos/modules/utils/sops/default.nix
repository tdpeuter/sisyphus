{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    # Add secrets.yml to the nix store
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age = {
      # Automatically import SSH keys as age keys
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # Use an age key that is expected to already be in the filesystem
      keyFile = "/var/lib/sops-nix/key.txt";
      # Generate new keys if the key specified above does not exist
      generateKey = true;
    };
    secrets = {
      "H4G0/ssh" = {
        format = "yaml";
        sopsFile = ../../../secrets/H4G0.yaml;
        owner = config.users.users.tdpeuter.name;
      };
    };
  };
}

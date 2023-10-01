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
      # generateKey = true;
    };
    secrets =
      let
        user = config.users.users.tdpeuter.name;
      in {
      "GitHub/ssh" = {
        format = "yaml";
        sopsFile = ../../../secrets/GitHub.yaml;
        owner = user;
      };
      "GitHub-UGent/ssh" = {
        format = "yaml";
        sopsFile = ../../../secrets/GitHub-UGent.yaml;
        owner = user;
      };
      "Hugo/ssh" = {
        format = "yaml";
        sopsFile = ../../../secrets/Hugo.yaml;
        owner = user;
      };
      "Git/ssh" = {
        format = "yaml";
        sopsFile = ../../../secrets/H4Git.yaml;
        owner = user;
      };
    };
  };
}

{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  home-manager.users.tdpeuter = {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "Hugo" = {
          hostname = "192.168.0.11";
          identitiesOnly = true;
          identityFile = "/run/secrets/Hugo/ssh";
          user = "admin";
        };
        "HPC" = {
          hostname = "login.hpc.ugent.be";
          identitiesOnly = true;
          identityFile = "/run/secrets/UGent/HPC/ssh";
          user = "vsc44995";
        };

        # Git authentication
        "git.depeuter.dev" = {
          hostname = "git.depeuter.dev";
          identitiesOnly = true;
          identityFile = "/run/secrets/Hugo/Gitea/ssh";
          user = "git";
        };
        "github.com" = {
          hostname = "github.com";
          identitiesOnly = true;
          identityFile = "/run/secrets/GitHub/ssh";
          user = "git";
        };
        "github.ugent.be" = {
          hostname = "github.ugent.be";
          identitiesOnly = true;
          identityFile = "/run/secrets/UGent/GitHub/ssh";
          user = "git";
        };
        "subgit.ugent.be" = {
          hostname = "subgit.ugent.be";
          identitiesOnly = true;
          identityFile = "/run/secrets/UGent/SubGit/ssh";
          user = "git";
        };
      };
    };
  };
}

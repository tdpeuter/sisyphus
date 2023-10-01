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
        "github.com" = {
          hostname = "github.com";
          identitiesOnly = true;
          identityFile = "/run/secrets/GitHub/ssh";
          user = "tdpeuter";
        };
        "github.ugent.be" = {
          hostname = "github.ugent.be";
          identitiesOnly = true;
          identityFile = "/run/secrets/GitHub-UGent/ssh";
          user = "tdpeuter";
        };
        "git.depeuter.dev" = {
          hostname = "git.depeuter.dev";
          identitiesOnly = true;
          identityFile = "/run/secrets/H4Git/ssh";
          user = "tdpeuter";
        };
      };
    };
  };
}

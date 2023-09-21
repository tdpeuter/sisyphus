{ config, lib, pkgs, ... }:

{
  home-manager.users.tdpeuter = {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "H4G0" = {
          hostname = "192.168.0.11";
          identitiesOnly = true;
          identityFile = "/run/secrets/H4G0/ssh";
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

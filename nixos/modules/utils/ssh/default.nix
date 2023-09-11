{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

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
      };
    };
  };
}

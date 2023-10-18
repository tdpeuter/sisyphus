{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.openssh;
in {
  options.sisyphus.services.openssh.enable = lib.mkEnableOption "OpenSSH";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}

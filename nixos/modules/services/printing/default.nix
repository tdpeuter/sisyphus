{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.printing;
in {
  options.sisyphus.services.printing.enable = lib.mkEnableOption "Printing";

  config = lib.mkIf cfg.enable {
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns = true;
        openFirewall = true;
      };
    };
  };
}

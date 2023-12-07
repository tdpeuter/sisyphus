{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.virtualisation.docker;
in {
  options.sisyphus.virtualisation.docker.enable = lib.mkEnableOption "Docker";

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableNvidia = true;
    };
  };
}

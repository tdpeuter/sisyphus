{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.virtualisation.docker;
in {
  options.sisyphus.virtualisation.docker.enable = lib.mkEnableOption "Docker";

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      # Because these are made for development purposes and not for servers
      enableOnBoot = false;
    };

    # Updated version of deprecated enableNvidia.
    hardware.nvidia-container-toolkit.enable = true;

    sisyphus.users.wantedGroups = [
      "docker"
    ];
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.home-manager;
in {
  options.sisyphus.programs.home-manager.enable = lib.mkEnableOption "Home-manager";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      home-manager
    ];

    home-manager.useGlobalPkgs = true;
  };
}

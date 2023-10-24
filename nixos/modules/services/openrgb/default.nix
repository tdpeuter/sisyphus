{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.openrgb;
in {
  options.sisyphus.services.openrgb.enable = lib.mkEnableOption "OpenRGB";

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "intel";
    };
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.openrgb;
in {
  options.sisyphus.services.openrgb.enable = lib.mkEnableOption "OpenRGB";

  config = lib.mkIf cfg.enable {
    services.udev.packages = with pkgs; [
      openrgb
    ];

    boot.kernelModules = [ "i2c-dev" ];

    hardware.i2c.enable = true;

    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "intel";
    };
  };
}

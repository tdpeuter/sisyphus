{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.openrgb;
in {
  options.sisyphus.services.openrgb.enable = lib.mkEnableOption "OpenRGB";

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "i2c-dev" ];

    environment.systemPackages = with pkgs; [
      openrgb-with-all-plugins
    ];

    hardware.i2c.enable = true;

    services = {
      hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
        motherboard = "intel";
      };

      udev.packages = with pkgs; [
        openrgb
      ];
    };
  };
}

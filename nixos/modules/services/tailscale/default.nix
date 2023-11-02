{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.services.tailscale;
in {
  options.sisyphus.services.tailscale.enable = lib.mkEnableOption "Tailscale";

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      package = pkgs-unstable.tailscale;
      useRoutingFeatures = "client";
    };
  };
} 

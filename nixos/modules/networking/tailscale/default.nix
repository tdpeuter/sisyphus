{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.networking.tailscale;
in {
  options.sisyphus.networking.tailscale.enable = lib.mkEnableOption "Tailscale";

  config = lib.mkIf cfg.enable {
    services = {
      tailscale = {
        enable = true;
        package = pkgs-unstable.tailscale;
        useRoutingFeatures = "client";
        extraDaemonFlags = [
          "--no-logs-no-support"
        ];
      };

      resolved.enable = true;
    };
  };
} 

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.networking.networkmanager;
in {
  options.sisyphus.networking.networkmanager.enable = lib.mkEnableOption "NetworkManager";

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;

      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };

    # Prevent slow boot times
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}

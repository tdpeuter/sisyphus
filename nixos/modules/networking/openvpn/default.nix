{ config, lib, ... }:

let
  cfg = config.sisyphus.networking.openvpn;
in {
  options.sisyphus.networking.openvpn.enable = lib.mkEnableOption "OpenVPN client";

  config = lib.mkIf cfg.enable {
    programs.openvpn3.enable = true;

    # https://github.com/NixOS/nixpkgs/issues/379074
    services.resolved.enable = true;
  };
}

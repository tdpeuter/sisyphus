{ config, inputs, lib, pkgs, ... }:

let
  cfg = config.sisyphus.networking.openconnect-sso;
in {
  options.sisyphus.networking.openconnect-sso.enable = lib.mkEnableOption "OpenConnect SSO";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.openconnect-sso.packages.${config.nixpkgs.localSystem.system}.default
    ];
  };
}

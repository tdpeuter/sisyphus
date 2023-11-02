{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.networking.openconnect-sso;
in {
  options.sisyphus.networking.openconnect-sso.enable = lib.mkEnableOption "OpenConnect SSO";

  config = lib.mkIf cfg.enable {
    nixpkgs = {
      config.permittedInsecurePackages = [
        "python3.10-requests-2.28.2"
        "python3.10-cryptography-40.0.1"
      ];
    };

    environment.systemPackages = with pkgs; [
      openconnect-sso
    ];
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.eid;
in {
  options.sisyphus.hardware.eid.enable = lib.mkEnableOption "Electronic identity card (eID)";

  config = lib.mkIf cfg.enable {
    services.pcscd = {
      enable = true;
      plugins = [ pkgs.ccid ];
    };

    environment.systemPackages = with pkgs; [
      eid-mw
    ];
  };
}

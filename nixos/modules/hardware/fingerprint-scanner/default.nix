{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.fingerprint-scanner;
in {
  options.sisyphus.hardware.fingerprint-scanner.enable = lib.mkEnableOption "Fingerprint scanner support";

  config = lib.mkIf cfg.enable {
    # Enable driver
    services.fprintd = {
      enable = true;

      # Enable Touch OEM Drivers library support
      tod = {
        enable = true;
        # Dell drivers
        driver = pkgs.libfprint-2-tod1-broadcom;
      };
    };

    # Start driver at boot
    systemd.services.fprintd = {
      wantedBy = [
        "multi-user.target"
      ];
      serviceConfig.Type = "simple";
    };
  };
}


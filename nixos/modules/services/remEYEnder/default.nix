{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.remEYEnder;
in {
  options.sisyphus.services.remEYEnder.enable = lib.mkEnableOption "Eye reminder";

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services.remEYEnder = {
        enable = true;
        description = "Send an eye reminder";
        serviceConfig.Type = "oneshot";
        script = builtins.readFile ./remEYEnder.sh;
        path = with pkgs; [
          libnotify
        ];
      };
      timers.remEYEnder = {
        enable = true;
        description = "Timer for remEYEnders, runs every 20 minutes.";
        wantedBy = [
          "timers.target"
        ];
        timerConfig = {
          OnActiveSec = "20min";
          OnUnitActiveSec = "20min";
          Unit = "remEYEnder.service";
        };
      };
    };
  };
}

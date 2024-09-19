{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.remEYEnder;

  icon = ./vecteezy_eyes-line-icon-vector-isolated_13932670.jpg;
in {
  options.sisyphus.services.remEYEnder.enable = lib.mkEnableOption "Eye reminder";

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services.remEYEnder = {
        enable = true;
        description = "Send an eye reminder";
        serviceConfig.Type = "oneshot";
        script = ''
          # Display reminder for 20 seconds.
          ${pkgs.libnotify}/bin/notify-send -t 20000 --icon=${icon} "RemEYEnder" "Look away from your screen :)"
        '';
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

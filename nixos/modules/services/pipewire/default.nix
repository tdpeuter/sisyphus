{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.pipewire;
in {
  options.sisyphus.services.pipewire.enable = lib.mkEnableOption "Pipewire";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;

      wireplumber = {
        enable = true;
        # Fix pops after silence
        extraConfig."99-disable-suspend" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                # Headphone jack on laptop
                { "node.name" = "alsa_output.pci-0000_00_1f.3.analog-stereo"; }
              ];
              actions = {
                update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
          ];
        };
      };
    };
  };
}

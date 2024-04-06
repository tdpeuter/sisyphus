{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.yubikey;
in {
  options.sisyphus.hardware.yubikey.enable = lib.mkEnableOption "YubiKey support";

  config = lib.mkIf cfg.enable {
    programs = {
      gnupg.agent = {
        enable = true;
        # TODO Necessary?
        # enableSSHSupport = true;
        # pinentryFlavor = "curses";
      };

      # yubikey-touch-detector.enable = true;
    };

    # Enable smart card reading
    services.pcscd.enable = true;

    environment.systemPackages = with pkgs; [
      yubikey-touch-detector
    ];

    # Send a notification if the YubiKey is waiting for touch.
    systemd.user.services.yubikey-touch-detector = {
      enable = true;
      description = "Detects when your YubiKey is waiting for a touch";
      path = with pkgs; [ yubikey-touch-detector ];
      script = ''exec yubikey-touch-detector --notify'';
      environment.YUBIKEY_TOUCH_DETECTOR_LIBNOTIFY = "true";
    };
  };
}

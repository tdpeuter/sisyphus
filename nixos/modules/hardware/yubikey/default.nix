{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.yubikey;
in {
  options.sisyphus.hardware.yubikey.enable = lib.mkEnableOption "YubiKey support";

  config = lib.mkIf cfg.enable {
    # Enable smart card reading
    services.pcscd.enable = true;

    programs.gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
    };
  };
}

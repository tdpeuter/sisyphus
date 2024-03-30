{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.yubikey;
in {
  options.sisyphus.hardware.yubikey.enable = lib.mkEnableOption "YubiKey support";

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      # TODO Necessary?
      # enableSSHSupport = true;
      # pinentryFlavor = "curses";
    };

    # Enable smart card reading
    services.pcscd.enable = true;
  };
}

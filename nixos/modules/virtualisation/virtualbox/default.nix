{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.virtualisation.virtualbox;
in {
  options.sisyphus.virtualisation.virtualbox.enable = lib.mkEnableOption "VirtualBox";

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      guest = {
        enable = true;
        x11 = true;
      };
    };
    users.extraGroups.vboxusers.members = [
      "user-with-access-to-virtualbox"
    ];
  };
}

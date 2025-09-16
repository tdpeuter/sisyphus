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
        enableHardening = true;
      };
      guest = {
        enable = true;
        clipboard = true;
        seamless = true;
        vboxsf = false; # Module not found?...
      };
    };

    # Define the group
    users.groups.vboxusers = {};

    sisyphus.users.wantedGroups = [
      config.users.groups.vboxusers.name # The group we defined earlier
      config.users.groups.dialout.name   # Serial Port
    ];
  };
}

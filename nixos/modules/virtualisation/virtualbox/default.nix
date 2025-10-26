{ config, lib, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.virtualisation.virtualbox;
in {
  options.sisyphus.virtualisation.virtualbox.enable = lib.mkEnableOption "VirtualBox";

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
      enableHardening = true;
      package = pkgs-unstable.virtualbox;
    };


    # https://www.virtualbox.org/ticket/22248#comment:1
    # and
    # https://github.com/NixOS/nixpkgs/pull/444438
    boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

    # Define the group
    users.groups.vboxusers = {};

    sisyphus.users.wantedGroups = [
      config.users.groups.vboxusers.name # The group we defined earlier
      config.users.groups.dialout.name   # Serial Port
    ];
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.virtualisation.qemu;
in {
  options.sisyphus.virtualisation.qemu.enable = lib.mkEnableOption "QEMU";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
    ];

    virtualisation.libvirtd.qemu.runAsRoot = false;
  };
}

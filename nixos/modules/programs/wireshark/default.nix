{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.wireshark;
in {
  options.sisyphus.programs.wireshark.enable = lib.mkEnableOption "Wireshark";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wireshark
    ];

    programs.wireshark = {
      enable = true;
      dumpcap.enable = true;
      usbmon.enable = false;
    };

    sisyphus.users.wantedGroups = [
      "wireshark"
    ];
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.ssh;
in {
  options.sisyphus.programs.ssh.enable = lib.mkEnableOption "SSH";

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enableAskPassword = false;
    };
  };
}

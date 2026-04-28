{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.git;
in {
  options.sisyphus.programs.git.enable = lib.mkEnableOption "Git";

  config.programs.git = lib.mkIf cfg.enable {
    enable = true;
    lfs.enable = true;
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.nix.flakes;
in {
  options.sisyphus.nix.flakes.enable = lib.mkEnableOption "Nix Flakes";

  config.nix = lib.mkIf cfg.enable {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixFlakes;
  };
}

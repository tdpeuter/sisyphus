{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.spotify-adblock;
in {
  options.sisyphus.programs.spotify-adblock.enable = lib.mkEnableOption "Spotify adblock";

  config = lib.mkIf cfg.enable {
    environment.etc."spotify-adblock/config.toml".source = "${pkgs.spotify-adblock}/config.toml";
  };
}

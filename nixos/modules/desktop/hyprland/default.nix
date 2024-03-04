{ config, lib, ... }:

let
  cfg = config.sisyphus.desktop.hyprland;
in {
  options.sisyphus.desktop.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}


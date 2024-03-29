{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.programs.direnv;
in {
  options.sisyphus.programs.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;  # Use nix-specific direnv.
    };

    # This is also done by setting programs.direnv.persistDerivations.
    # Keep derivations so shells don't break.
    nix.extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };
}

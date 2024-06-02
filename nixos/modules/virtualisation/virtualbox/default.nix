{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.virtualisation.virtualbox;

  # I like to override the virtualbox package because it is frequently
  # and rebuilds take quite long.
  inherit (pkgs) fetchurl;
  version = "7.0.10";
  virtualbox-override = pkgs.virtualbox.overrideAttrs (oldAttrs: {
    src = fetchurl {
      url = "https://download.virtualbox.org/virtualbox/${version}/VirtualBox-${version}.tar.bz2";
      sha256 = "0b1e6d8b7f87d017c7fae37f80586acff04f799ffc1d51e995954d6415dee371";
    };
  });
in {
  options.sisyphus.virtualisation.virtualbox.enable = lib.mkEnableOption "VirtualBox";

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
        package = virtualbox-override;
      };
      guest = {
        enable = true;
        clipboard = true;
        seamless = true;
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

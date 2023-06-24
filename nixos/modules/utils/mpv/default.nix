{ config, system, lib, pkgs-unstable, ... }:

{
  home-manager.users.tdpeuter.home.packages = with pkgs-unstable; [
    mpv
  ];
}

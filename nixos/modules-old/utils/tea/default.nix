{ config, lib, pkgs, ... }:

{

  home-manager.users.tdpeuter.home = {
    packages = with pkgs; [
      tea
    ];
  };
}

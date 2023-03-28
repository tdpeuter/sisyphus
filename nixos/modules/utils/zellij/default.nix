{ config, pkgs, lib, ... }:

{
    home-manager.users.tdpeuter.home = {
        packages = [ pkgs.zellij ];
        file.".config/zellij".source = ../../../../stow/zellij/.config/zellij;
    };
}

{ config, lib, pkgs, ... }:

{
    home-manager.users.tdpeuter.home = {
        packages = with pkgs; [
            vifm
            font-awesome_5
        ];

        file = {
            ".config/vifm".source = ../../../../stow/vifm/.config/vifm;
        };
    };
}

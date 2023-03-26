{ config, lib, pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            vifm
            font-awesome_5
        ];

        file = {
            ".config/vifm".source = ../../../../stow/vifm/.config/vifm;
        };
    };
}

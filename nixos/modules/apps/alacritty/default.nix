{ inputs, lib, config, pkgs, ... }:

{
    home-manager.users.tdpeuter = { pkgs, ... }: {
        home = {
            packages = with pkgs; [
                alacritty
            ];

            file = {
                ".config/alacritty".source = ../../../../stow/alacritty/.config/alacritty;
            };
        };
    };
}

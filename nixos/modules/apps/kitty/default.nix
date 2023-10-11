{ inputs, lib, config, pkgs, ... }:

{
    home-manager.users.tdpeuter = { pkgs, ... }: {
        home = {
            packages = with pkgs; [
              kitty
            ];

            file = {
                ".config/kitty".source = ../../../../stow/kitty/.config/kitty;
            };
        };
    };
}

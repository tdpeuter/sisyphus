{ config, lib, pkgs, ... }:

{
    services.xserver = {
        enable = true;

        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

    };

    environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
        xterm
    ]) ++ (with pkgs.gnome; [
        gedit
        gnome-terminal
    ]);
}

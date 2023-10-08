{ config, lib, pkgs, ... }:

{
  home-manager.users.tdpeuter = {
    home.packages = with pkgs; [
      spotify
      spotify-adblock
    ];

    # Set the desktop entry to use adblock.
    # TODO Is it possible to inherit all other values?
    xdg.desktopEntries.spotify = {
      name = "Spotify";
      exec = "LD_PRELOAD=${pkgs.spotify-adblock}/lib/libspotifyadblock.so spotify %U";
    };
  };
}

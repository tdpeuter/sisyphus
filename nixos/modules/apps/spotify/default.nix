{ config, lib, pkgs, ... }:

{
  home-manager.users.tdpeuter = {
    home = {
      packages = with pkgs; [
        spotify
        spotify-adblock
      ];

      file.".config/spotify-adblock/config.toml".source = "${pkgs.spotify-adblock}/config.toml";
    };

    # Set the desktop entry to use adblock.
    # TODO Is it possible to inherit all other values?
    xdg.desktopEntries.spotify = {
      name = "Spotify";
      genericName = "Music Player";
      icon = "spotify-client";
      exec = "env LD_PRELOAD=${pkgs.spotify-adblock}/lib/libspotifyadblock.so spotify %U";
      mimeType = [ "x-scheme-handler/spotify" ];
      categories = [ "Audio" "Music" "Player" "AudioVideo" ];
      settings = {
        TryExec = "spotify";
        StartupWMClass = "spotify";
      };
    };
  };
}

{
    imports = [
        ./alacritty
        ./firefox
        ./spotify
        ./steam
        ./thunderbird
        # ./virtualbox
    ];

    home-manager.users.tdpeuter = { pkgs, ... }: {
      home.packages = with pkgs; [
        brave
        caprine-bin
        discord
        jellyfin-media-player
        libreoffice-fresh
        mattermost-desktop
        nextcloud-client
        obsidian
        pinentry_qt
        qalculate-gtk
        zathura
        zoom-us
      ];
    };
}

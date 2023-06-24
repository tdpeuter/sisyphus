{
  imports = [
    ./mpv
    ./vifm
    ./vim
    ./zellij
  ];

  home-manager.users.tdpeuter = { pkgs, ... }: {
    home.packages = with pkgs; [
      direnv
      duf
      git-crypt
      lynx
      w3m
      zenith
    ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      git = {
        enable = true;
        userName = "tdpeuter";
        userEmail = "tibo.depeuter@gmail.com";
        extraConfig = {
          core.editor = "vim";
        };
        includes = [
          {
            path = "~/.gitconfig-ugent";
            condition = "gitdir:~/Nextcloud/Documenten/UGent";
          }
        ];
      };
    };
  };
}

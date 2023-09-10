{
  imports = [
    ./mpv
    ./sops
    ./ssh
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
      nsxiv
      w3m
      wget
      zenith-nvidia
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

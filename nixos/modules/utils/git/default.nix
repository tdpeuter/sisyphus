{ config, lib, pkgs, ... }:

{
  home-manager.users.tdpeuter = {
    programs.git = {
      enable = true;
      userName = "tdpeuter";
      userEmail = "tibo.depeuter@gmail.com";
      extraConfig = {
        core.editor = "vim";
      };
      ignores = [
        "*.swp"
      ];
      includes = [
        {
          path = "~/.gitconfig-ugent";
          condition = "gitdir:~/Nextcloud/Documenten/UGent";
        }
      ];
    };
  };
}

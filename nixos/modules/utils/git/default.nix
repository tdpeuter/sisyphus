{ config, lib, pkgs, ... }:

{
  home-manager.users.tdpeuter = {
    programs.git = {
      enable = true;
      userName = "Tibo De Peuter";
      userEmail = "tibo.depeuter@gmail.com";
      extraConfig = {
        core.editor = "vim";
      };
      ignores = [
        "*.swp"
      ];
      includes = [
        {
          condition = "gitdir:~/university/"; # Trailing backslash is necessary!
          contentSuffix = ".gitconfig";
          contents = {
            user.email = "tibo.depeuter@ugent.be";
          };
        }
      ];
    };
  };
}

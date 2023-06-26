{ config, lib, pkgs, ... }:

{

  home-manager.users.tdpeuter.home = {
    packages = with pkgs; [
      vifm

      chafa # Terminal image previewer
      glow  # Terminal Markdown renderer

      font-awesome_5
    ];

    # Put files separately so history still works
    file = {
      ".config/vifm/colors".source = ../../../../stow/vifm/.config/vifm/colors;
      ".config/vifm/scripts".source = ../../../../stow/vifm/.config/vifm/scripts;
      ".config/vifm/vifmrc".source = ../../../../stow/vifm/.config/vifm/vifmrc;
    };
  };
}

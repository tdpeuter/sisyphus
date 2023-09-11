{
  imports = [
    ./git
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
    };
  };
}

{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;
  user = config.users.users.tdpeuter.name;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets = lib.mkIf config.sisyphus.programs.sops.enable (
      let
        HomeLab = {
          format = "yaml";
          sopsFile = ../../secrets/HomeLab.yaml;
          owner = user;
        };
        personal = {
          format = "yaml";
          sopsFile = ../../secrets/personal.yaml;
          owner = user;
        };
        UGent = {
          format = "yaml";
          sopsFile = ../../secrets/UGent.yaml;
          owner = user;
        };
      in {
        "UGent/HPC/ssh" = UGent;

        # Git authentication
        "Gitea/ssh" = personal;
        "GitHub/ssh" = personal;
        "UGent/GitHub/ssh" = UGent;
        "UGent/SubGit/ssh" = UGent;

        # HomeLab

        # Physical hosts
        "HomeLab/Hugo/ssh" = HomeLab;
        "HomeLab/Roxanne/ghost/ssh" = HomeLab;
        "HomeLab/HTPC/ssh" = HomeLab;

        # Virtual hosts
        "HomeLab/Gitea/ssh" = HomeLab;
        "HomeLab/Nextcloud/ssh" = HomeLab;
        "HomeLab/Vaultwarden/ssh" = HomeLab;
        "HomeLab/NixOS/admin/ssh" = HomeLab;
      });
  };
}

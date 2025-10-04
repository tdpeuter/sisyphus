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
        "UGent/Dwengo" = UGent;

        # Git authentication
        "Gitea/ssh" = personal;
        "GitHub/ssh" = personal;
        "UGent/GitHub/ssh" = UGent;
        "UGent/SubGit/ssh" = UGent;

        # HomeLab
        "HomeLab/Gitea/ssh" = HomeLab;
        "HomeLab/Hugo/ssh" = HomeLab;
        "HomeLab/Nextcloud/ssh" = HomeLab;
        "HomeLab/NixOS/admin/ssh" = HomeLab;
      });
  };
}

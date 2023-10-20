{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;
  user = config.users.users.tdpeuter.name;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets = lib.mkIf config.sisyphus.programs.sops.enable (
      let
        Hugo = {
          format = "yaml";
          sopsFile = ../../secrets/Hugo.yaml;
          owner = user;
        };
        UGent = {
          format = "yaml";
          sopsFile = ../../secrets/UGent.yaml;
          owner = user;
        };
      in {
        "Hugo/ssh" = Hugo;
        "UGent/HPC/ssh" = UGent;

        "GitHub/ssh" = {
          format = "yaml";
          sopsFile = ../../secrets/GitHub.yaml;
          owner = user;
        };
        "Hugo/Gitea/ssh" = Hugo;
        "UGent/GitHub/ssh" = UGent;
        "UGent/SubGit/ssh" = UGent;
      });
  };
}

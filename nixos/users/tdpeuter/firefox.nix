{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.sisyphus.users.tdpeuter;
  user = config.users.users.tdpeuter.name;
in {
  config = lib.mkIf cfg.enable {
    home-manager.users.tdpeuter.programs.firefox = lib.mkIf config.sisyphus.programs.home-manager.enable {
      enable = true;
      package = pkgs-unstable.firefox.override {
        cfg = {
          speechSynthesisSupport = true; # Allow Text-to-speech in e.g. Discord
        };
        nativeMessagingHosts = with pkgs; [
          tridactyl-native
        ];
        extraPolicies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          OfferToSaveLogins = false;
        };
      };

      profiles.tdpeuter.search= {
        default = "DuckDuckGo";
        force = true;
        engines = {
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Qwant".metaData.hidden = true;

          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "GitHub" = {
            urls = [{
              template = "https://github.com/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
                { name = "type"; value = "repositories"; }
              ];
            }];

            icon = "${pkgs.icosystem}/share/icons/icosystem/scalable/apps/github-mark.svg";
            definedAliases = [ "@gh" ];
          };
        };
      };
    };
  };
}

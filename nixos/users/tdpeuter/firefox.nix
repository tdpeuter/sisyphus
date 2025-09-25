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
        # https://mozilla.github.io/policy-templates/
        extraPolicies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          FirefoxHome = {
            SponsoredTopSites = false;
            SponsoredPocket = false;
          };
          OfferToSaveLogins = false;

          # https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
          ExtensionSettings = {
            "amazon@search.mozilla.org".installation_mode = "blocked";
            "google@search.mozilla.org".installation_mode = "blocked";
          };

          # Anything in about:config
          Preferences = {
            "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = {
              Value = false;
              Status = "locked";
            };
            "browser.newtabpage.pinned" = {
              Value = "[]";
              Status = "default";
            };
          };
        };

        # Support smart cards
        pkcs11Modules = with pkgs-unstable; [
          eid-mw
        ];
      };

      languagePacks = [
        "en-GB"
        "nl"
      ];

      profiles.tdpeuter.search= {
        default = "ddg"; # Reference by id instead of by name
        force = true;
        engines = {
          "bing".metaData.hidden = true;
          "ebay".metaData.hidden = true;

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
          "NixOS Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
        };
      };
    };
  };
}

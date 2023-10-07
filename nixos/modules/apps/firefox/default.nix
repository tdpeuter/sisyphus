{ inputs, lib, config, pkgs, ... }:

{
  home-manager.users.tdpeuter = {
    home.packages = with pkgs; [
      speechd
    ];

    programs.firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg = {
          enableTridactylNative = true;
        };
        extraPolicies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          ExtensionSettings = {};
          OfferToSaveLogins = false;
        };
      };
      profiles.tdpeuter = {
        search = {
          default = "DuckDuckGo";
          force = true;
          engines = {
            "eBay".metaData.hidden = true;
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
          };
        };
      };
    };
  };
}
            

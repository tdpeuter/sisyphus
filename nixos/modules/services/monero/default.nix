{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.services.monero;
in {
  options.sisyphus.services.monero.enable = lib.mkEnableOption "Monero";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      monero-cli
    ];

    services = {
      monero.enable = true;
      xmrig = {
        enable = true;
        settings = {
          autosave = true;
          background = true;
          pause-on-battery = true;
          pasue-on-active = true;
          donate-level = 5;
          cpu = true;
          opencl = false;
          cuda = true;
          pools = [
            {
              # url = "monerohash.com:9999";
              url = "127.0.0.1:18081"; # Local node
              user = "44FjmmLn1k1GC1AFTLSdWDZ17CHB2h3eRCnfkfTQBucHaKX1AGS5oLERR1FEaHxPQcUNwrbEfsgbY4Y6bYJm6ZrdCYGwg7b";
              keepalive = true;
              tls = true;
            }
          ];
        };
      };
    };
  };
}

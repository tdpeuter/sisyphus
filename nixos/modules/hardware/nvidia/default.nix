{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.nvidia;

  do-offloading = builtins.elem cfg.model [ "Quadro T2000" ];
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  options.sisyphus.hardware.nvidia = {
    enable = lib.mkEnableOption "NVIDIA GPU support";
    model = lib.mkOption {
      type = lib.types.enum [ "" "Quadro T2000" "RTX 2060" ];
      default = "";
      example = "Quadro T2000";
      description = lib.mdDoc "The model of NVIDIA GPU card";
    };
    gui-settings = lib.mkEnableOption "NVIDIA settings menu";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
  
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        nvidiaSettings = cfg.gui-settings;
        powerManagement = {
          enable = do-offloading;
          finegrained = do-offloading;
        };

        prime = lib.mkMerge [
          (lib.mkIf do-offloading {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
          })
          (lib.mkIf (cfg.model == "Quadro T2000") {
            intelBusId = "PCI::00:02:0";
            nvidiaBusId = "PCI:01:00:0";
          })
          (lib.mkIf (cfg.model == "RTX 2060") {
            sync.enable = true;
            intelBusId = "PCI::00:02:0";
            nvidiaBusId = "PCI:01:00:0";
          })
        ];
      };
    };

    environment.systemPackages = lib.mkIf do-offloading [
      nvidia-offload
    ];
  };
}

{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.nvidia;

  # The graphics cards for which to do offloading
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
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-ocl
          intel-compute-runtime
          intel-graphics-compiler
          opencl-clhpp
          opencl-headers
          ocl-icd
        ];
      };

      nvidia = {
        # Use the NVidia open source kernel module (or not)
        open = false;
        branch = "stable";
        # To override the default package set by the branch:
        #package = config.boot.kernelPackages.nvidiaPackages.stable;
        # Modesetting is required.
        modesetting.enable = true;
        nvidiaSettings = cfg.gui-settings;
        powerManagement = {
          enable = do-offloading;
          finegrained = do-offloading;
        };

        # Avoid flickering
        forceFullCompositionPipeline = true;

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

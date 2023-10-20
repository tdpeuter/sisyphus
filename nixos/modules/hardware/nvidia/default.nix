{ config, lib, pkgs, ... }:

let
  cfg = config.sisyphus.hardware.nvidia;

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
      type = lib.types.enum [ "" "T2000" "RTX 2060" ];
      default = "";
      example = "T2000";
      description = lib.mdDoc "The model of NVIDIA GPU card";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
  
    hardware = {
      opengl.enable = true;
      nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;

        prime = lib.mkIf (cfg.model == "T2000") {
          offload.enable = true;
          intelBusId = "PCI::00:02:0";
          nvidiaBusId = "PCI:01:00:0";
        };
      };
    };

    environment.systemPackages = lib.mkIf (cfg.model != "") [
      nvidia-offload
    ];
  };
}

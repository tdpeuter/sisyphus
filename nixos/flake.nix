{
  description = "System configuration of my machines using flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openconnect-sso = {
      url = github:ThinkChaos/openconnect-sso/fix/nix-flake;
      inputs = {
        flake-utils.follows = "utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs@{
    self, nixpkgs, nixpkgs-unstable,
    devshell, flake-utils, home-manager, openconnect-sso, sops-nix, utils,
    ... }:
    let
      system = "x86_64-linux";

      unfreePackages = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
        "corefonts"
        "nvidia-settings" "nvidia-x11" "nvidia-persistenced"
        "Oracle_VM_VirtualBox_Extension_Pack"
        "spotify"
        "steam" "steam-original" "steam-run"
        "vista-fonts"
        "nvidia-persistenced" # Docker
      ];
    in
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfreePredicate = unfreePackages;

      sharedOverlays = [
        (import ./overlays/cmdtime)
        (import ./overlays/icosystem)
        (import ./overlays/letter)
        (import ./overlays/spotify)
      ];

      hostDefaults = {
        inherit system;

        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfreePredicate = unfreePackages;
          };
        };

        modules = [
          home-manager.nixosModule
          sops-nix.nixosModules.sops
          ./modules
          ./users
        ];
      };

      hosts = {
        Tibo-NixDesk.modules = [ ./hosts/Tibo-NixDesk ];
        Tibo-NixFat.modules  = [ ./hosts/Tibo-NixFat  ];
        Tibo-NixTest.modules = [ ./hosts/Tibo-NixTest ];
      };
    };
}

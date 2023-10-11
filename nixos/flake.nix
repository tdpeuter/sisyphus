{
  description = "System configuration of my machines using flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
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
    devshell, flake-utils, home-manager, sops-nix, utils,
    ... }:
    let
      system = "x86_64-linux";
    in
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig = {
        allowUnfree = true;
      };

      sharedOverlays = [
        (import ./overlays/letter)
      ];

      hostDefaults = {
        inherit system;

        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
          };
        };

        modules = [
          home-manager.nixosModule
          sops-nix.nixosModules.sops
          ./modules
        ];
      };

      hosts = {
        Tibo-NixDesk.modules = [ ./hosts/Tibo-NixDesk ];
        Tibo-NixFat.modules  = [ ./hosts/Tibo-NixFat  ];
        Tibo-NixTest.modules = [ ./hosts/Tibo-NixTest ];
      };
    };
}

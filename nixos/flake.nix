{
  description = "System configuration of my machines using flakes";
 
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
      };
    };
    utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs@{
    self, nixpkgs,
    devshell, flake-utils, home-manager, utils,
    ... }:
    let
      system = "x86_64-linux";
    in
    utils.lib.mkFlake {
      inherit self inputs;
      homeManagerConfigurations = {
        tdpeuter = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules = [
            ./users/tdpeuter/home.nix
            {
              home = {
                username = "tdpeuter";
                homeDirectory = "/home/tdpeuter";
              };
            }
          ];
        };
      };
      nixosConfigurations = {
        Tibo-NixFat = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/Tibo-NixFat ];
        };
        Tibo-NixTest = nixpkgs.lib.nixossSytem {
          inherit system;
          modules = [ ./hosts/Tibo-NixTest ];
        };
      };    
    };
}

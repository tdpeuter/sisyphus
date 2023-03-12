{
  description = "System configuration";
 
  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
  let
    system = "x86_64-linux"; # Use flake tools?
    
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
  in rec {
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
      Tibo-NixTest = lib.nixosSystem { # Use hostname
        inherit system;
        modules = [
          ./hosts/test
          nur.nixosModules.nur
        ];
      };
    };
  };
}

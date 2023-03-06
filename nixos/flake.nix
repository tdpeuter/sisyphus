{
  description = "System configuration";
 
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux"; # Use flake tools?
    
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      tdpeuter = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
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
          ./system/configuration.nix
        ];
      };
    };
  };
}

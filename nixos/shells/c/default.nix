{
  description = "C Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
  flake-utils.lib.eachDefaultSystem (system:
  let
    lib = import lib;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        cmake
        gcc
        gnumake
        valgrind

        # You might want to use your own IDE.
        (jetbrains.plugins.addPlugins jetbrains.clion [ "github-copilot" ])
      ];
    };
  });
}

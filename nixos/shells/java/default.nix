{
  description = "Java Flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem
  ( system:
  let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        jdk8
        openjdk17

        # You might want to use your own IDE.
        (jetbrains.plugins.addPlugins jetbrains.idea-ultimate [ "github-copilot" ])
      ];
    };
  });
}

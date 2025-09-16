{
  description = "System configuration of my machines using flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openconnect-sso = {
      url = "github:ThinkChaos/openconnect-sso/fix/nix-flake";
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
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self, nixpkgs, nixpkgs-unstable,
    flake-utils, home-manager, openconnect-sso, sops-nix, utils, zen-browser,
    ... }:
    let
      system = utils.lib.system.x86_64-linux;

      unfreePackages = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
        "corefonts"
        "nvidia-settings" "nvidia-x11" "nvidia-persistenced"
        "Oracle_VirtualBox_Extension_Pack"
        "spotify"
        "steam" "steam-unwrapped" "steam-run"
        "vista-fonts"
        "intel-ocl"
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

      outputsBuilder = channels: {
        devShells = {
          default = channels.nixpkgs.mkShell {
            name = "devShell";
            packages = with channels.nixpkgs; [
              nodejs
            ];
          };
          unstable = let
            pkgs = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in channels.nixpkgs.mkShell {
            name = "Unstable";
            packages = with pkgs; [
              anytype
            ];
          };
          rust = let
            pkgs = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in channels.nixpkgs.mkShell {
            name = "Rust Shell";
            packages = with pkgs; [
              rustc
              cargo
              rustup

              (jetbrains.plugins.addPlugins jetbrains.rust-rover [ "github-copilot" ])
            ];
          };
          webdev = let
            pkgs = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in channels.nixpkgs.mkShell {
            name = "Web development Shell";
            packages = with pkgs; [
              nodejs
              playwright-test
              playwright-driver
              playwright-driver.browsers

              # IDE's
              (jetbrains.plugins.addPlugins jetbrains.webstorm [ "github-copilot" ])
            ];

            shellHook = ''
              export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
              export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
            '';
          };
        };
      };
    };
}

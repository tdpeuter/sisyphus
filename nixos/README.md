# nixos

Nix Flake for my Linux machines running NixOS.

The directory structure can be interpreted as follows:

- [`flake.nix`](./flake.nix): Main entrypoint for the configuration
- [hosts/*hostname*](./hosts): Host-specific configuration by setting options
- [modules](./modules): Declarations of options
- [modules/users/*username*](./modules/users): Since users are dependent on a host machine to exist, they are defined as a module as well
- [overlays](./overlays): Attribute overrides of Nix Packages
- [secrets](./secrets): Encrypted files that hold secrets, for example SSH private keys


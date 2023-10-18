# NixOS

Nix Flake configuration for my Linux machines running NixOS.

## Structure

The directory structure is organized as follows:

- [`flake.nix`](./flake.nix): Main entrypoint for the configuration.
- [hosts/*hostname*](./hosts): Host-specific configuration by setting options. Each host has its own folder.
- [modules](./modules): Declarations of configuration options.
- [modules/users/*username*](./modules/users): User-specific configuration. Users are defined as modules, as they are dependent on a host machine.
- [overlays](./overlays): Attribute overrides for Nix Packages.
- [secrets](./secrets): Encrypted files that store sensitive information, such as SSH private keys.

[Modules](https://nixos.wiki/wiki/NixOS_modules) are a key component of NixOS. They encapsulate various configuration options, which should make it easy for you to integrate it into your specific configuration.

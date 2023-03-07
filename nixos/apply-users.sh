#!/usr/bin/env bash
pushd ~/projects/sisyphus/nixos
nix build .#homeManagerConfigurations.tdpeuter.activationPackage
./result/activate
popd

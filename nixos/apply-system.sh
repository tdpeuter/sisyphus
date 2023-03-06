#!/bin/sh
pushd ~/projects/sisyphus/nixos
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd

#!/bin/sh
pushd ~/projects/sisyphus/nixos
sudo nixos-rebuild switch --flake .#
popd

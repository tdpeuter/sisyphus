#!/usr/bin/env bash
pushd ~/projects/sisyphus/nixos
sudo nixos-rebuild switch --flake .# --show-trace
popd
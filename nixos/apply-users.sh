#!/bin/sh
pushd ~/projects/sisyphus/nixos
home-manager switch -f ./users/tdpeuter/home.nix
popd

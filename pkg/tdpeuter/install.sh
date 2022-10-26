#!/usr/bin/env bash

cd "${1}"

>&2 echo "Installing ${2}"
git clone --depth 1 --progress "https://aur.archlinux.org/${2}.git"
cd "${2}"
git pull

makepkg -isc --asdeps "tdpeuter-desktop" --noconfirm

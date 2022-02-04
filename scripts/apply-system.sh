#!/bin/sh
set -x
pushd ~/.dotfiles
sudo nixos-rebuild switch -I nixos-config=./system/configuration.nix
popd

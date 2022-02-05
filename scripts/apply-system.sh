#!/bin/sh
set -x
pushd ~/.dotfiles
sudo nixos-rebuild switch --flake .#
popd

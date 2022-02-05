#!/bin/sh
set -x
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.kaixi.activationPackage
./result/activate
popd

#!/bin/sh
set -xe
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.kaixi.activationPackage
./result/activate
popd

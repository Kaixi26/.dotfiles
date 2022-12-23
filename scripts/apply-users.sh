#!/bin/sh
set -xe

pushd ~/.dotfiles

nix build ".#homeManagerConfigurations.$NIX_HOMEMANAGER_USER.activationPackage"
./result/activate

popd

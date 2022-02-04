#!/bin/sh
set -x
pushd ~/.dotfiles
home-manager switch -f ./users/kaixi/home.nix
popd

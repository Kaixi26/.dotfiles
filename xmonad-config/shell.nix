{ pkgs ? import <nixpkgs> {} }:
let
  ghc = pkgs.haskellPackages.ghcWithPackages (ps: with ps; [
    xmonad
    xmonad-contrib
    xmonad-extras
    cabal-install
    hlint
    haskell-language-server
    ormolu
  ]);
in
  pkgs.stdenv.mkDerivation {
    name = "xmonad-config";
    buildInputs = [ ghc ];
  }
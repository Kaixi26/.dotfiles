{ pkgs, ... }:
let
  direnv = {
    name = "vscode-direnv";
    publisher = "cab404";
    version = "1.0.0";
    sha256 = "+nLH+T9v6TQCqKZw6HPN/ZevQ65FVm2SAo2V9RecM3Y=";
  };
  nix-env-selector = {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "1.0.7";
    sha256 = "DnaIXJ27bcpOrIp1hm7DcrlIzGSjo4RTJ9fD72ukKlc=";
  };
  haskell-linter = {
    name = "haskell-linter";
    publisher = "hoovercj";
    version = "0.0.6";
    sha256 = "MjgqR547GC0tMnBJDMsiB60hJE9iqhKhzP6GLhcLZzk=";
  };
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = (with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      bbenoist.nix
      justusadam.language-haskell
      haskell.haskell
      golang.go
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      direnv
      nix-env-selector
      haskell-linter
    ];
  };
}
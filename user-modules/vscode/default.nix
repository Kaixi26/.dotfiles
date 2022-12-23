{ pkgs, ... }:
let
  nix-env-selector = {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "1.0.9";
    sha256 = "DnaIXJ27bcpOrIp1hm7DcrlIzGSjo4RTJ9fD72ukKlc=";
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
      jnoortheen.nix-ide
      justusadam.language-haskell
      haskell.haskell
      golang.go
      ms-python.python
      james-yu.latex-workshop
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      nix-env-selector
    ];
  };
}

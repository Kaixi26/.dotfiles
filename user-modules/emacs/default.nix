{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    extraPackages = [
      pkgs.git
      pkgs.ripgrep
      pkgs.fd
    ]
  };
}

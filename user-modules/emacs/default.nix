{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      pkgs.git
      pkgs.ripgrep
      pkgs.fd
    ];
  };
}

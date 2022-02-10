args@{ ... }:
{
  programs.rofi = {
    enable = true;
    theme = import ./theme.nix args;
  };
}
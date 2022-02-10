{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [ 
    ./alacritty 
    ./redshift
    ./polybar
    ./picom
    ./zsh
    ./vscode
    ./rofi
    ./nvim
  ];
  
  home.packages = with pkgs; [
    discord
    #nuclear
    #jetbrains.idea-ultimate
    alloy6
    #texlive.combined.scheme-full
    killall
    comma
  ];


  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  # check config further
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

}

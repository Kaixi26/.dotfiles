inputs@{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  programs.zsh.sessionVariables = {
    NIX_HOMEMANAGER_USER = "work";
  };

  imports = [ 
    ./alacritty 
    ./vscode
    ./nvim
    ./zsh
  ];
  
  home.packages = with pkgs; [
    nixfmt
  ];

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

}

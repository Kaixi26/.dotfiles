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
    ./dunst
  ];
  
  home.packages = with pkgs; [
    discord
    nuclear
    jetbrains.idea-ultimate
    alloy6
    #texlive.combined.scheme-full
    zoom-us
    spotify
    killall
    comma
    mpv
    lxappearance
    i3lock
    ripgrep
    transmission-gtk
    arandr
    xournal
    flameshot
    thunderbird-bin birdtray
    blender
    mattermost-desktop
  ];

  services.network-manager-applet.enable = true;

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

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
    ./sxhkd
    ./dwm-status
  ];
  
  home.packages = with pkgs; [
    discord
    jetbrains.idea-ultimate
    alloy6
    #texlive.combined.scheme-full
    zoom-us
    spotify
    killall
    comma
    jq
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
    ark
    zathura
    gimp
    peek
    gst_all_1.gstreamer gst_all_1.gst-plugins-ugly x264
    jdk8
    godot
    tenacity
    libsForQt5.kamoso
  ];

  programs.zsh.sessionVariables = {
    NIX_HOMEMANAGER_USER = "kaixi";
  };

  programs.tmux.enable = true;

  services.network-manager-applet.enable = true;

  programs.obs-studio.enable = true;

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

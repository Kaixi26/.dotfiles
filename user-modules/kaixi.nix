{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [ 
    ./alacritty 
    ./redshift
    ./polybar
  ];
  
  home.packages = with pkgs; [
    discord
    #nuclear
    #jetbrains.idea-ultimate
    alloy6
    #texlive.combined.scheme-full
    killall
  ];


  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    inactiveOpacity = "0.98";
    noDNDShadow = true;
    noDockShadow = true;
    vSync = true;
  };

  programs.rofi = {
    enable = true;
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history.path = ".cache/zsh/history";
    history.share = false;
    initExtra = ''
      autoload -U colors && colors
      PS1="%B%{$fg[magenta]%}%1~ ⊨%{$reset_color%}%b "
      PATH=$PATH:~/.dotfiles/scripts/
    '';
    shellAliases = {
      v = "nvim";
    };
    profileExtra = ''
    '';
  };

  # check config further
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

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
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "vscode-direnv";
      publisher = "cab404";
      version = "1.0.0";
      sha256 = "+nLH+T9v6TQCqKZw6HPN/ZevQ65FVm2SAo2V9RecM3Y=";
    }] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "nix-env-selector";
      publisher = "arrterian";
      version = "1.0.7";
      sha256 = "DnaIXJ27bcpOrIp1hm7DcrlIzGSjo4RTJ9fD72ukKlc=";
    }] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "haskell-linter";
      publisher = "hoovercj";
      version = "0.0.6";
      sha256 = "MjgqR547GC0tMnBJDMsiB60hJE9iqhKhzP6GLhcLZzk=";
    }];

    
  };
}

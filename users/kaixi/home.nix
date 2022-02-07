{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kaixi";
  home.homeDirectory = "/home/kaixi";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    alacritty
    discord
    #nuclear
    #jetbrains.idea-ultimate
    alloy6
    #texlive.combined.scheme-full
  ];

  services.polybar = {
    enable = true;
    config = {
      "bar/top" = {
        monitor = "\${env:MONITOR:HDMI-1}";
        width = "100%";
        height = "3%";
        radius = 0;
        modules-left = "xworkspaces";
        modules-center = "date";
      };
      "module/date" = {
        type = "internal/date";
        internal = "60";
        date = "%d.%m.%y";
        time = "%H:%M";
        label = "%time% %date%";
      };
      "module/xworkspaces" = {
        type = "internal/xworkspaces";
      };
    };
    script = ''
      
    '';
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

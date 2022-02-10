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

  imports = [ 
    ./alacritty 
  ];
  
  home.packages = with pkgs; [
    discord
    #nuclear
    #jetbrains.idea-ultimate
    alloy6
    #texlive.combined.scheme-full
    killall
  ];

  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = {
      "colors" = {
        background = "#282A2E";
        background-alt = "#373B41";
        foreground = "#C5C8C6";
        primary = "#F0C674";
        secondary = "#8ABEB7";
        alert = "#A54242";
        disabled = "#707880";
      };
      "bar/top" = {
        monitor = "\${env:MONITOR:HDMI-1}";
        width = "100%";
        height = "2.5%";
        line-size = "3";
        radius = 0;
        modules-left = "xworkspaces";
        modules-center = "date";
        modules-right = "pulseaudio cpu battery";
        separator = " | ";
        font-0 = "hack:size=8";
        tray-position = "right";
        padding-right = "5";
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
        label-active = "%name%";
        label-active-background = "\${colors.background-alt}";
        label-active-underline= "\${colors.primary}";
        label-active-padding = "1";
        label-occupied = "%name%";
        label-occupied-padding = "1";
        label-urgent = "%name%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = "1";
        label-empty = "";
        label-empty-foreground = "\${colors.disabled}";
        label-empty-padding = "1";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume-prefix = "VOL ";
        format-volume-prefix-foreground = "\${colors.primary}";
        format-volume = "<label-volume>";
        label-volume = "%percentage%%";
        label-muted = "muted";
        label-muted-foreground = "\${colors.disabled}";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = "2";
        format-prefix = "CPU ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage:2%%";
      };
      "module/battery" = {
        type = "internal/battery";
        full-at = "99";
        battery = "BAT0";
        adapter = "ADP1";
        poll-interval = "5";
      };
    };
    script = ''
      polybar top &
    '';
  };

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

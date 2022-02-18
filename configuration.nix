{ config, lib, pkgs, modulesPath, ... }:
{

  imports = [
    ./system-modules/sound
    ./system-modules/bluetooth
  ];

  time.timeZone = "Europe/Lisbon";

  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [ "1.1.1.1" ];

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pt-latin1";
  };

  fonts.fonts = with pkgs; [
    lmodern
    lmmath
    (nerdfonts.override { fonts = [ "FiraMono" "Hack" ]; })
  ];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.xmonad = {
      enable = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad_0_17_0
        haskellPackages.xmonad-contrib_0_17_0
        haskellPackages.xmonad-extras_0_17_0
      ];
    };
    displayManager.defaultSession = "none+xmonad";
    layout = "pt";
    xkbOptions = "ctrl:swapcaps";
    libinput.enable = true;
  };

    environment.sessionVariables = rec {
      XDG_CACHE_HOME    = "\${HOME}/.cache";
      XDG_CONFIG_HOME   = "\${HOME}/.config";
      XDG_BIN_HOME      = "\${HOME}/.local/bin";
      XDG_DATA_HOME     = "\${HOME}/.local/share";
      XMONAD_CONFIG_DIR = "\${HOME}/.dotfiles/xmonad-config";
      TERM              = "alacritty";
      BROWSER           = "firefox";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    PATH = [ 
      "\${XDG_BIN_HOME}"
    ];
  };

  sound.enable = true;
  security.rtkit.enable = true;
  #hardware.pulseaudio.enable = true;

  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  programs.light.enable = true;
  services.cpupower-gui.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget git
    firefox
    networkmanagerapplet
    mypaint
    btop
    man-pages man-pages-posix
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.kaixi = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "sound" ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
  };
}

{ config, lib, pkgs, modulesPath, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Portugal";

  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [ "1.1.1.1" ];

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pt-latin1";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    layout = "pt";
    xkbOptions = "ctrl:swapcaps";
    libinput.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget git
    firefox
    networkmanagerapplet
    mypaint
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.kaixi = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
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
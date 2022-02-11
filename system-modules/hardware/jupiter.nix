{ config, lib, pkgs, modulesPath, ... }:
{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "ath9k_htc" "ath9k"];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;

  fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "auto";
    };

  fileSystems."/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };

  swapDevices = [
      { device = "/dev/disk/by-label/swap"; }
    ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}


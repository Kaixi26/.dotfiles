{ config, lib, pkgs, modulesPath, ... }:
{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.useDHCP = false;
  networking.interfaces.enp2s0f1.useDHCP = true;
  networking.interfaces.wlp0s20f0u4.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  hardware.enableAllFirmware = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    };
  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}


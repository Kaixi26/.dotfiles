{ config, lib, pkgs, modulesPath, ... }:
{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "ath9k_htc" "ath9k"];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/160b27db-caa9-4abf-845d-8b1acd23f3ac";
      fsType = "ext4";
    };
 
  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/E545-A151";
      fsType = "vfat";
    };
 
  swapDevices =
    [ { device = "/dev/disk/by-uuid/9519bc0d-36d0-4801-9bbd-335851d0af84"; }
    ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}


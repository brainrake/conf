{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ./lib/desktop.nix
    ];

  networking.hostName = "anus";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5cb82a76-e43f-4fde-8bfb-c7290a3f14ee";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8A65-1C96";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/swapfile"; }
    ];

  nix.maxJobs = lib.mkDefault 4;

  services.xserver.videoDrivers = lib.mkForce [ "intel" ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

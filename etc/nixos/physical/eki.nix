{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/hardware/network/broadcom-43xx.nix>
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../logical/graphical.nix
    ];

  networking.hostName = "eki";

  boot.initrd.luks.devices = [ { device = "/dev/nvme0n1p6"; name = "ct"; } ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/".device = "/dev/ct/root";
  fileSystems."/".options = [ "defaults" "noatime" ];
  fileSystems."/boot".device = "/dev/nvme0n1p1";
  fileSystems."/w" = {
    device = "/dev/nvme0n1p3";
    options = [ "rw" "defaults" "umask=000" "noatime" ];
    fsType = "ntfs-3g";
  };

  services.xserver.videoDrivers = [ "intel" ];

  powerManagement.cpuFreqGovernor = "powersave";

  # zramSwap.enable = true;
  # zramSwap.memoryPercent = 25;
}

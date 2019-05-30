{ config, lib, pkgs, ... }:

{
  imports = [ ../logical/workstation.nix ];

  networking.hostName = "eki";

  i18n.consoleFont = "ter-i32n";
  i18n.consolePackages = [ pkgs.terminus_font ];

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

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };
}

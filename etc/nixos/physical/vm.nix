{ config, pkgs, ... }:
{
  imports = [ ./graphical.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixbox";
  boot.initrd.checkJournalingFS = false;

  services.xserver.videoDrivers = [ "virtualbox" ];

  virtualisation.virtualbox.guest.enable = true;
}

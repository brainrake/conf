{ config, pkgs, lib, ... }:
{
  imports = [ ../logical/desktop.nix ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/disk/by-id/wwn-0x57c3548161b1f760";
    gfxmodeBios = "960x720";
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "uas" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "pci=noaer" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/93bf7aef-d09d-4662-890f-8f7e99d2828d";
    fsType = "ext4";
  };
 
  networking = {
    defaultGateway = { address = "192.168.100.1"; interface = "enp1s0"; };
    hostName = "calculon";
    domain = "newt";
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    interfaces.enp1s0.ipv4.addresses = [ {
      address = "192.168.100.10";
      prefixLength = 24;
    } ];
  };

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "enp1s0" ];
    extraConfig = ''
      option subnet-mask 255.255.255.0;
      option broadcast-address 192.168.100.255;
      option routers 192.168.100.1;
      option domain-name-servers 8.8.8.8, 8.8.4.4;
      option domain-name "feld.eket.su";
      subnet 192.168.100.0 netmask 255.255.255.0 {
        range 192.168.100.127 192.168.100.189;
      }
    '';
    machines = [
      { ethernetAddress = "30:52:cb:e8:20:e7"; ipAddress = "192.168.100.20"; hostName = "eki"; } 
      { ethernetAddress = "fc:aa:14:34:0f:79"; ipAddress = "192.168.100.30"; hostName = "lada"; } 
      { ethernetAddress = "18:fe:34:f5:dc:51"; ipAddress = "192.168.100.51"; hostName = "ix-k"; } 
      { ethernetAddress = "2c:3a:e8:00:a7:0f"; ipAddress = "192.168.100.52"; hostName = "ix-r"; } 
      { ethernetAddress = "2c:3a:e8:00:a8:70"; ipAddress = "192.168.100.53"; hostName = "ix-t"; } 
    ];
  };

  services.nginx = {
    enable = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."feld.eket.su" = {
      forceSSL = true;
      enableACME = true;
      locations."/".root = pkgs.writeTextDir "index.html" ''
        blarf
      '';
      locations."/www" = {
        root = "/www";
        extraConfig = ''
          rewrite ^/www/(.*)$ /$1 break;
        '';
      };
    };
  };
}

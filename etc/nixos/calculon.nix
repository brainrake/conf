{ config, pkgs, lib, ... }:
{
  imports = [ ./lib/desktop.nix ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/disk/by-id/wwn-0x57c3548161b1f760";
    gfxmodeBios = "960x720";
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "uas" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "pci=noaer" ];

  zramSwap.enable = true;

  users.users.nomadbase-backup = {
    isNormalUser = true;
    createHome = true;
    home = "/data/nomadbase-backup/";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDpf/FmDi1MxCbaQ4jLSCG4xUP+D+ikquNFp9ajqDzNCxG4Wm5fQpbOc0xOKoGQX3yiInItDgIdxOCrVyFkMoNma2c+N3O+bNpgxUH26sYY2g9f6G95OpM4J7gwonrcYDnKxt/GPasSSPCNkmH5Q9b8RHmRaz1mk08Rg6xA/GdQCO77hD+RG8GcbArscQmgSrr9X2sdAJrhDJq5ysuNs799grgd4hvItXHgkxWfTZ+hNupgtAEeaP6qm0D1/5di22Plj4RL0J891U9WUWPIk0aJWPswc82fw8Gk8FuoEiHhEY3g7Lts8YnMYVuJmYgqOsagf7cZDlGoav1nRsaJ/xK3 root@nomadbase" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/93bf7aef-d09d-4662-890f-8f7e99d2828d";
    fsType = "ext4";
  };

  fileSystems."/data/" = {
    device = "/dev/disk/by-label/data";
    options = [ "defaults" "nofail" ];
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
      { ethernetAddress = "74:70:fd:d7:f5:c8"; ipAddress = "192.168.100.20"; hostName = "eki"; } 
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

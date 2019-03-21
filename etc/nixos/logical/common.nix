{ config, pkgs, ... }:

{
  nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;

  boot.earlyVconsoleSetup = true;
  boot.supportedFilesystems = [ "ext" "exfat" "vfat" "ntfs" "xfs" ];

  networking.firewall.enable = false;

  security.rtkit.enable = true;

  powerManagement.enable = true;

  programs.zsh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv6 = true;
    publish = {
      enable = true;
      domain = true;
      workstation = true;
      hinfo = true;
      addresses = true;
      userServices = true;
    };
  };

  services.openssh = {
    enable = true;
    forwardX11 = true;
  };

  users.users.ssdd = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker" "dialout" "audio" "video" "storage" "adbusers" "sway"];
    shell = pkgs.zsh;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "18.09";
}

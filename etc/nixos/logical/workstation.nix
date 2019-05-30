{ config, pkgs, lib, ... }:

{
  imports = [ ./desktop.nix ];

  services.keybase.enable = true;
  services.kbfs.enable = true;

  virtualisation.lxd.enable = true;
}

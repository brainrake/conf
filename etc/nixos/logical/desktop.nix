{ config, pkgs, lib, ... }:

{
  imports = [ ./graphical.nix ];

  services.keybase.enable = true;
  services.kbfs.enable = true;

  programs.chromium.enable = true;
  programs.chromium.extensions = [
    "cfhdojbkjhnklbpkdaibdccddilifddb" # Adblock Plus
    "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
  ];

  #services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.libinput.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    chromium
  ];

  # TODO:
  #   - bluetooth audio
  #   - opensnitch
  #   - little flocker
}

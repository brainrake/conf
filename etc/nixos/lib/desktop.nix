{ config, pkgs, lib, ... }:

{
  imports = [ ./graphical.nix ];

  programs.spacefm.enable = true;
  programs.browserpass.enable = true;
  programs.chromium.enable = true;
  programs.chromium.extensions = [
    "cfhdojbkjhnklbpkdaibdccddilifddb" # Adblock Plus
    "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
  ];
  programs.sway.enable = true;
  programs.sway.extraPackages = with pkgs; [ swaylock swayidle xwayland rxvt_unicode dmenu i3status i3status-rust light ];

  #services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.libinput.enable = lib.mkForce false;

  security.pam.services.gdm.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    chromium
    browserpass
  ];

  # TODO:
  #   - bluetooth audio
  #   - opensnitch
  #   - little flocker
}

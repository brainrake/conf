{ config, pkgs, ... }:

{
  imports = [ ./musnix ];

  musnix = {
    enable = true;
    soundcardPciId = "00:1f.3";
    kernel = {
      optimize = true;
      realtime = true;
      latencytop = true;
    };
    rtirq.enable = true;
  };
}

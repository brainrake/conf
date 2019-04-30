{config, lib, pkgs, ...}:

{
  imports = [ ./common.nix ];

  hardware = {
    opengl = rec {
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel ]; # libvdpau-va-gl vaapiVdpau ] ;
      extraPackages32 = extraPackages;
    };
    bluetooth = {
      enable = true;
      extraConfig = ''
        [General]
        Enable=Source,Sink,Media,Socket
      '';
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  networking.networkmanager.enable = true;

  programs.slock.enable = true;

  nix = {
    distributedBuilds = true;
    maxJobs = 4;
    buildMachines = [
      /*
      {
        hostName = "eket.su";
        sshUser = "nix";
        sshKey = "TODO";
        maxJobs = 4;
        speedFactor = 2;
        system = "x86_64-linux";
      }
      */
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  environment.systemPackages = with pkgs; [
    rxvt_unicode arandr
    mpv evince transmission_gtk firefox
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    enableCtrlAltBackspace = true;

    windowManager.i3.enable = true;

    synaptics = {
      enable = true;
      twoFingerScroll = true;
      vertEdgeScroll = false;
      palmDetect = true;
      accelFactor = "0.1";
      additionalOptions = ''
        Option "VertScrollDelta" "-27"
        Option "HorizScrollDelta" "-27"
        Option "SingleTapTimeout" "30"
        Option "MaxTapTime" "100"
        Option "SingleTapTimeout" "100"
      '';
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [ corefonts terminus_font terminus_font_ttf ubuntu_font_family carlito hasklig mononoki fira fira-code fira-code-symbols fira-mono source-sans-pro source-serif-pro source-code-pro noto-fonts noto-fonts-cjk noto-fonts-emoji ];
  };
}

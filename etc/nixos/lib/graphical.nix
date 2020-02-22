{config, lib, pkgs, ...}:

{
  imports = [ ./common.nix ];

  hardware = {
    opengl = rec {
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl ] ;
      extraPackages32 = extraPackages;
    };
    bluetooth = {
      enable = true;
      config = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };
  };

  networking.networkmanager.enable = true;

  programs.slock.enable = true;
  programs.light.enable = true;

  nix = {
    distributedBuilds = true;
    maxJobs = 4;
    buildMachines = [
      /*
      {
        hostName = "eket.su";
        sshUser = "nix";
        sshKey = "...";
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
    i3 i3status dmenu networkmanager_dmenu pasystray volumeicon
    rxvt_unicode arandr
    mpv evince transmission_gtk firefox pcmanfm
  ];

  # services.xserver = {
  #   enable = true;
  #   layout = "us";
  #   enableCtrlAltBackspace = true;

  #   windowManager.i3.enable = true;

  #   libinput = {
  #     enable = true;
  #     naturalScrolling = true;
  #     clickMethod = "clickfinger";
  #     accelSpeed = "0.1";
  #     additionalOptions = ''
  #       Option "SingleTapTimeout" "30"
  #       Option "MaxTapTime" "100"
  #    '';
  #   };

  #   # synaptics = {
  #   #   enable = true;
  #   #   twoFingerScroll = true;
  #   #   vertEdgeScroll = false;
  #   #   palmDetect = true;
  #   #   accelFactor = "0.1";
  #   #   additionalOptions = ''
  #   #     Option "VertScrollDelta" "-27"
  #   #     Option "HorizScrollDelta" "-27"
  #   #     Option "SingleTapTimeout" "30"
  #   #     Option "MaxTapTime" "100"
  #   #     Option "SingleTapTimeout" "100"
  #   #   '';
  #   # };
  # };

  fonts = {
    enableFontDir = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
      carlito
      corefonts
      fira
      fira-code
      fira-code-symbols
      fira-mono
      hasklig
      mononoki
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
      source-sans-pro
      source-serif-pro
      terminus_font
      terminus_font_ttf
      ubuntu_font_family
    ];
  };
}


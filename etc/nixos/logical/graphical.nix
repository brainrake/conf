{congig, lib, pkgs, ...}:

{
  imports = [ ./common.nix ];

  boot.plymouth.enable = true;

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

  programs.sway.enable = true;
  programs.adb.enable = true;

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
    toilet
    gparted rfkill powertop
    rxvt_unicode
  ];

  services.keybase.enable = true;

  services.kbfs.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.i3.enable = true;
    displayManager.slim = {
      enable = true;
      theme = pkgs.fetchurl {
        url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
        sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
      };
      defaultUser = "ssdd";
      extraConfig = ''
        welcome_msg
        session_msg
        intro_msg
        username_msg
        password_msg
      '';
    };
    enableCtrlAltBackspace = true;
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

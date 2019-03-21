{
  allowUnfree = true;

  chromium.enablePepperFlash = true;

  packageOverrides = pkgs: rec {
    my_ = pkgs.buildEnv {
      name = "my_";
      paths = [ my_dev ];
    };
    my_dev = pkgs.buildEnv {
      name = "my_dev";
      paths = [ my_desktop ] ++ (with pkgs; [
        gnome3.seahorse
        firefox
        git gcc racket direnv meld file graphviz imagemagick
        sublime3 atom
        mixxx
        gimp
        urbit
      ]);
    };
    my_desktop = pkgs.buildEnv {
      name = "my_desktop";
      paths = [ my_tools ] ++ (with pkgs; [
        i3 i3status i3lock dmenu networkmanager_dmenu
        pasystray volumeicon networkanagerapplet
        mpv evince geeqie feh pcmanfm
        chromium
        xorg.xbacklight xorg.xev xorg.xkbcomp xorg.xmodmap hsetroot glxinfo xorg.xev compton
        rxvt_unicode scrot arandr autorandr lxappearance gcolor2 paprefs pavucontrol
        transmission_gtk kdeconnect
        vanilla-dmz
        # pidgin pidginotr pidginlatex purple-hangouts purple-plugin-pack toxprpl
      ]);
    };
    my_tools = pkgs.buildEnv {
      name = "my_tools";
      paths = with pkgs; [
        iputils bind nmap mtr wget gnupg mkpasswd
        htop psmisc unzip bc mc mc-solarized
        pciutils lm_sensors
        nox
      ];
    };
    mc-solarized = pkgs.writeTextFile {
      name = "mc-solarized";
      destination = "/share/mc-solarized/solarized.ini";
      text =pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/peel/mc/05009685f34c48e0da58662214253c31c1620d47/solarized.ini";
        sha256 = "13p2flyn0i1c88xkycy2rk24d51can8ff31gh3c6djni3p981waq";
      };
    };

    /* bitwig-studio2 = pkgs.bitwig-studio2.overrideAttrs (old : {
      postUnpack = ''
        rm root/opt/bitwig-studio/bin/bitwig.jar
        cp ${./bitwig.nix} root/opt/bitwig-studio/bin/bitwig.jar
      '';
    }); */
  };
}

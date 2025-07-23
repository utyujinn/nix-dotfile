{ config, pkgs, ... }:

{
  system.stateVersion = "24.11";
  imports =[
    ./hardware-configuration.nix
    ./applications.nix
    ./i3.nix
    #./home.nix
#    ./user.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  security.sudo.extraRules=[
  {
    users = [ "utyujin" ];
    commands = [
    {
      command = "ALL";
      options = [ "SETENV" "NOPASSWD" ];
    }
    ];
  }
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.sudo.wheelNeedsPassword = false;
  #security.allowUserMounting = true;

  programs.zsh.enable=true;

  #home-manager.users.utyujin= import ./home.nix;

  users.users.utyujin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Utyujin";
    extraGroups = [ "wheel" "uucp" "fuse" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes" ;

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
 
  networking.wireless.iwd.enable=true;
  hardware.bluetooth.enable=true;
 
  services.pipewire={
    enable = true;
    pulse.enable = true;
  };

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  fonts = {
    packages = with pkgs; [
      (pkgs.stdenv.mkDerivation {
        name = "setofont";
        src = pkgs.fetchurl {
          url = "https://dforest.watch.impress.co.jp/library/s/setofont/11015/setofont_v_6_20.zip";
          sha256 = "sha256-fQBrqkwOmzY3qV7ml/N1Xte6HeWFbL71m0mSxEe40TU=";
        };
        nativeBuildInputs = [ pkgs.unzip ];
          #unar -o . $src
          #find . -name "*.ttf" -exec mv {} $out/share/fonts/truetype/ \;
        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          cp *.ttf $out/share/fonts/truetype/
        '';
      })

      (pkgs.stdenv.mkDerivation {
        name = "Kosefont JP";
        src = pkgs.fetchFromGitHub {
          owner = "lxgw";
          repo = "kose-font";
          rev = "v3.123";
          sha256 = "sha256-WDVMsdU9ZWWl0txziT70lbS0gGde+aCl5TBZ4OhEjHg=";
        };
        installPhase = ''
          install -d -m755 $out/share/fonts/truetype
          find . -name "*.ttf" -exec install -m644 {} $out/share/fonts/truetype/ \;
        '';
      })

#      (pkgs.stdenv.mkDerivation {
#        name = "xioalai";
#        src = pkgs.fetchurl {
#          url = "https://github.com/lxgw/kose-font/releases/download/v3.123/Xiaolai-Regular.ttf";
#          sha256 = "sha256-QvhQ9UCoqUlptcU9MhgXLCKf2xjOuknOmuEEx9D+Nl0=";
#        };
#        nativeBuildInputs = [ pkgs.unzip ];
#          #unar -o . $src
#          #find . -name "*.ttf" -exec mv {} $out/share/fonts/truetype/ \;
#        #unpackPhase = '''';
#        phases = [ "installPhase" ];
#        installPhase = ''
#          mkdir -p $out/share/fonts/truetype
#          cp *.ttf $out/share/fonts/truetype/Xiaolai-Regular.ttf
#        '';
#      })

#      noto-fonts-cjk-sans
    ];
          #mkdir -p $out/share/fonts/truetype
          #cp {*.ttf,*.otf} $out/share/fonts/truetype/

    fontconfig = {
      defaultFonts = {
        serif = [ "Kosefont JP" "setofont" ];# "Noto Sans CJK JP"];
        sansSerif = [ "Kosefont JP" "setofont" ];# "Noto Sans CJK JP"];
        monospace = [ "Kosefont JP" "setofont" ];# "Noto Sans CJK JP"];
      };
    };
  };
  home-manager.users.utyujin = {
    dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };

    # Wayland, X, etc. support for session vars
    systemd.user.sessionVariables = config.home-manager.users.utyujin.home.sessionVariables;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}

{ config, pkgs, lib, ... }:
{
  system.stateVersion = "24.11";

  imports = [ ./hardware-configuration.nix ];

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  users.users.utyujin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Utyujin";
    extraGroups = [ "wheel" "uucp" "fuse" "docker" "video" "input" ];
    packages = with pkgs; [ ];
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraRules = [{
      users = [ "utyujin" ];
      commands = [{
        command = "ALL";
        options = [ "SETENV" "NOPASSWD" ];
      }];
    }];
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  home-manager = {
    users.utyujin = import ./laptop2-home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
  };

  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        qt6Packages.fcitx5-chinese-addons
        fcitx5-nord
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 3000 ];
  networking.wireless.iwd.enable = true;
  hardware.bluetooth.enable = true;

  # Wayland portal for screen sharing / file picker
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Wayland display manager
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
      user = "greeter";
    };
  };

  # keyd: system-level key remapping (xkeysnailのWayland代替)
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "leftcontrol";
          muhenkan = "rightalt";
          # tap=esc, hold=rightmeta
          henkan = "overload(meta, esc)";
          # tap=enter, hold=rightcontrol
          enter = "overload(control, enter)";
        };
        "control:R" = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
        };
        "meta:R" = {
          h = "A-left";
          j = "A-down";
          k = "A-up";
          l = "A-right";
          n = "pagedown";
          p = "pageup";
        };
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      udev-gothic
      source-han-serif
      source-han-sans
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
    ];
    fontconfig.defaultFonts = {
      serif     = [ "Source Han Serif" "Kosefont JP" ];
      sansSerif = [ "Source Han Sans"  "Kosefont JP" ];
      monospace = [ "UDEV Gothic" ];
    };
  };

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    logind.settings.Login.HandlePowerKey = "suspend";
    tlp = {
      enable = true;
      settings = {
        BACKLIGHT_CONTROL_ON_AC = 0;
        BACKLIGHT_CONTROL_ON_BAT = 0;
        RESTORE_DEVICE_STATE_ON_STARTUP = 0;
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
      };
    };
    resolved.enable = true;
    tailscale.enable = true;
    openvpn.servers.laptop = {
      config = "config /home/utyujin/laptop.ovpn";
      updateResolvConf = true;
      autoStart = false;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    # Development
    python3
    uv
    gcc
    git
    cmake
    gnumake
    vscode
    zed-editor
    lazygit
    google-cloud-sdk-gce
    nodejs
    pnpm
    python313Packages.django
    claude-code
    gemini-cli
    qwen-code
    codex
    rustc
    cargo
    clippy
    rustfmt
    ltspice
    iverilog
    gtkwave
    kicad
    gnuplot

    # Text Editors
    vim
    neovim
    emacs

    # Terminal Tools
    alacritty
    wget
    yazi
    pcmanfm
    zsh
    zsh-autosuggestions
    wl-clipboard
    dbus
    rclone
    tmux
    zoxide
    fzf
    fd
    tree
    gh
    bat
    ripgrep
    atuin
    tenv
    cloudflared

    # Launcher
    albert

    # Wayland / Sway ecosystem
    waybar
    mako
    grim
    slurp
    awww
    swaylock
    swayidle
    kanshi
    pavucontrol
    brightnessctl
    wlsunset

    # Tablet UI
    iwgtk
    nwg-panel
    nwg-drawer
    nwg-dock
    nwg-menu
    wvkbd
    lisgd
    rot8

    # Web Browsers
    vivaldi
    google-chrome
    firefox

    # Office & Docs
    libreoffice
    xournalpp
    obsidian
    kdePackages.okular
    slack
    zoom-us

    # Graphics & Media
    krita
    inkscape
    flameshot
    digikam
    nomacs
    obs-studio
    snes-pixel-editor

    # System Tools
    unar
    poppler-utils
    blobdrop
    espanso-wayland
    iio-sensor-proxy
    rustdesk
    jq

    # Gaming
    wla-dx
    mesen

    # Pen (Wayland対応 libinput経由)
    libwacom
  ];

  environment.sessionVariables = {
    PATH = "$PATH:.";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  nixpkgs.overlays = [
    (final: prev: {
      snes-pixel-editor = final.callPackage ./mypackage/snes-pixel-editor.nix { };
      qwen-code = final.callPackage ./mypackage/qwen-code.nix { };
    })
  ];
}

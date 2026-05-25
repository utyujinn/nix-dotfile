{ config, pkgs, lib, ... }:
{
  system.stateVersion = "24.11";

  imports = [./hardware-configuration.nix];

  programs = {
    zsh.enable=true;
    nix-ld.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes" ;

  users.users.utyujin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Utyujin";
    extraGroups = [ "wheel" "uucp" "fuse" "docker" "video" ];
    packages = with pkgs; [];
  };

  security.sudo = {
    wheelNeedsPassword = false;
    extraRules = [
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
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  home-manager = {
    users.utyujin = import ./laptop-home.nix;
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

  networking.firewall = {
    allowedTCPPorts = [ 3000 ]; # TCP
    # allowedUDPPorts = [ ... ]; # UDP
  };
  
  networking.wireless.iwd.enable=true;
  hardware.bluetooth.enable=true;

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
    fontconfig = {
      defaultFonts = {
        serif     = [ "Source Han Serif" "Kosefont JP" ];
        sansSerif = [ "Source Han Sans"  "Kosefont JP" ];
        monospace = [ "UDEV Gothic" ];
      };
    };
  };

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };
  
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    
    libinput.enable = true;
    displayManager.defaultSession = "none+i3";
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager = {
        startx.enable = true;
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
    };

    pipewire={
      enable = true;
      pulse.enable = true;
    };
    logind.settings.Login = {
	  	HandlePowerKey = "suspend";
	  };
    
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
    openvpn.servers = {
      laptop = {
        config = ''
          config /home/utyujin/laptop.ovpn
        '';
		  	updateResolvConf = true;
        autoStart = false;
      };
    };

    xserver.wacom.enable = true;
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
    arduino-ide
    git
    cmake
    gnumake
    vscode
    lazygit
    google-cloud-sdk-gce
    nodejs
    pnpm
    python313Packages.django
    claude-code
    gemini-cli
    qwen-code
    codex
		antigravity
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
    xclip
    dbus
    rclone
    tmux
    zoxide
    fzf
    tree
    gh
    copyq
    bat
    ripgrep
    rofi
    rofi-calc
    rofi-systemd
    rofi-bluetooth
    rofi-power-menu
    atuin
    tenv
    cloudflared
    
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
    brightnessctl
    pavucontrol
    xkeysnail
    onboard
    unar
    poppler-utils
    blobdrop
    espanso
    slock
    iio-sensor-proxy
    gnomeExtensions.screen-rotate
		rustdesk

    # Desktop
    xrandr
    xinit
    arandr
    autorandr
    xf86-input-libinput
    at-spi2-core
    feh
    rofi
    picom
    i3-auto-layout
    jq

    # Gaming
    wla-dx
    mesen

    # Pen

    xf86_input_wacom
    libwacom
    
    # 完全リセット用スクリプト（root権限）
    (writeShellScriptBin "wacom-usb-reset" ''
      if [ "$EUID" -ne 0 ]; then
        echo "This script requires root privileges. Use: sudo wacom-usb-reset"
        exit 1
      fi
      
      echo "=== Wacom USB Reset (Root) ==="
      
      # Wacom USBデバイスを見つけてリセット
      for device in /sys/bus/usb/devices/*/idVendor; do
        if [ -f "$device" ] && [ "$(cat "$device" 2>/dev/null)" = "056a" ]; then
          device_path=$(dirname "$device")
          product_file="$device_path/idProduct"
          if [ -f "$product_file" ] && [ "$(cat "$product_file" 2>/dev/null)" = "52b0" ]; then
            echo "Found Wacom HID 52B0 at $device_path"
            echo "Resetting USB device..."
            echo 0 > "$device_path/authorized"
            sleep 2
            echo 1 > "$device_path/authorized"
            echo "USB reset complete"
            break
          fi
        fi
      done
      
      # カーネルモジュールのリロード
      echo "Reloading wacom kernel module..."
      ${pkgs.kmod}/bin/modprobe -r wacom 2>/dev/null || true
      sleep 1
      ${pkgs.kmod}/bin/modprobe wacom
      
      echo "=== USB reset complete ==="
    '')
  ];

  environment.sessionVariables = {
    PATH = "$PATH:.";
    XDG_DATA_DIRS = lib.mkForce (
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:" +
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:" +
      "${pkgs.gtk4}/share/gsettings-schemas/${pkgs.gtk4.name}:" +
      "${pkgs.gtk4}/share:" +
      "${pkgs.glib}/share/glib-2.0/schemas:" +
      "$XDG_DATA_DIRS"
    );
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  nixpkgs.overlays = [
    (final: prev: {
      snes-pixel-editor = final.callPackage ./mypackage/snes-pixel-editor.nix {};
      qwen-code = final.callPackage ./mypackage/qwen-code.nix {};
    })
  ];
}

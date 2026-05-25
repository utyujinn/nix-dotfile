{ config, pkgs, lib, inputs, ... }:
let
  kiri-pkg = inputs.kiri.packages.${pkgs.system}.default;
in
{
  system.stateVersion = "24.11";

  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
  };

  users.users.utyujin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Utyujin";
    extraGroups = [ "wheel" "uucp" "fuse" "docker" "video" "input" "seat" "audio" ];
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
    users.utyujin = import ./kiri-home.nix;
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
  };

  networking.wireless.iwd.enable = true;
  hardware.bluetooth.enable = true;

  # DRM/KMS GPU access
  hardware.graphics.enable = true;

  # seatd for unprivileged DRM access (kiri uses libseat)
  services.seatd.enable = true;

  # dconf daemon — needed for GTK theme settings in home-manager
  programs.dconf.enable = true;

  # kiri Wayland compositor — auto-login as utyujin
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${kiri-pkg}/bin/kiri --drm";
        user = "utyujin";
      };
      initial_session = {
        command = "${kiri-pkg}/bin/kiri --drm";
        user = "utyujin";
      };
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
  };

  fonts = {
    packages = with pkgs; [
      udev-gothic
    ];
    fontconfig.defaultFonts = {
      serif = [ "UDEV Gothic" ];
      sansSerif = [ "UDEV Gothic" ];
      monospace = [ "UDEV Gothic" ];
    };
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    kiri-pkg

    # Terminals (kiri の Ctrl+Alt+T で起動)
    foot
    alacritty

    # Development
    git
    vim
    neovim
    lazygit
    gh
    claude-code

    # Terminal tools
    zsh
    zsh-autosuggestions
    wl-clipboard
    tmux
    zoxide
    fzf
    fd
    ripgrep
    bat
    tree
    yazi

    # Wayland utilities
    grim
    slurp
    mako
    brightnessctl
    pavucontrol

    # Tablet
    wvkbd           # オンスクリーンキーボード
    libwacom        # スタイラス
    iio-sensor-proxy  # 自動回転
    libinput

    # Web
    firefox
    vivaldi

    # System
    dbus
    jq
    unar
  ];

  environment.sessionVariables = {
    PATH = "$PATH:.";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}

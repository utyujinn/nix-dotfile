{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
  };
  services.tailscale.enable = true;
  services.openvpn.servers = {
    laptop = {
      config = ''
        config /home/utyujin/laptop.ovpn
      '';
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
    ####################
    # Development      #
    ####################
    python3
    uv
    gcc
    arduino-ide
    git
    cmake
    gnumake
    #R
    #rstudio
    vscode
    lazygit
    google-cloud-sdk-gce
    nodejs
    nodePackages.pnpm
    python313Packages.django
    claude-code

    ####################
    # Text Editors     #
    ####################
    vim
    neovim
    emacs

    ####################
    # Terminal Tools   #
    ####################
    alacritty
    wget
    yazi
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
    #ulauncher
    bat
    ripgrep
    rofi
    rofi-calc
    rofi-systemd
    rofi-bluetooth
    rofi-power-menu

    ####################
    # Web Browsers     #
    ####################
    vivaldi
    firefox

    ####################
    # Office & Docs    #
    ####################
    libreoffice
    xournalpp
    obsidian
    kdePackages.okular
    texstudio
    texlive.combined.scheme-full
    httrack
    rnote
    wechat
    #anki
    slack

    ####################
    # Graphics & Media #
    ####################
    krita
    flameshot
    digikam
    obs-studio
    snes-pixel-editor

    ####################
    # System Tools     #
    ####################
    #light
    brightnessctl
    xkeysnail
    onboard
    #exiftool
    unar
    poppler_utils
    blobdrop
    espanso
    slock
    iio-sensor-proxy
    gnomeExtensions.screen-rotate

    ####################
    # Gaming & Retro   #
    ####################
    protontricks
    wla-dx
    mesen

    ####################
    # Tmp              #
    ####################

    ####################
    # Work             #
    ####################
    ruff
    lefthook

  ];
}

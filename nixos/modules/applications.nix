{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    python3
    uv
    rclone
    arduino-ide
    protontricks
    #anki
    texstudio
    texlive.combined.scheme-full
    #haskell-ci
    dbus
    vim
    neovim
    emacs
    gcc
    git
    #pcmanfm
    wget
    alacritty
    vivaldi
    xournalpp
    krita
    libreoffice
    flameshot
    obsidian
    kdePackages.okular
    onboard
    unar
    poppler_utils
    xclip
    blobdrop
    yazi
    zsh
    zsh-autosuggestions
    #zsh-autocompletion
    R
    rstudio
    light
    #firefox
    #sl
    #ripdrag
    exiftool
    #ffmpeg
    vscode
    brightnessctl
    anki
    rnote
    digikam
    
    wla-dx
    
    cmake
    gnumake

    xkeysnail
    obs-studio
    code-cursor

    mesen
    zsnes2
    claude-code
    lazygit
    
    nodejs
    nodejs
    docker
    google-cloud-sdk-gce
    tenv
    nodePackages.pnpm
    python313Packages.django
    
    #pkg-config
    #qtcreator
    #xorg.libX11
    #xorg.libXext
    #qt6.full
    #hunspell
    #gsettings-desktop-schemas
    #gtk3
    #gtk4
    #vulkan-headers

    firebase-tools
    gh
    
    snes-pixel-editor
  ];
}

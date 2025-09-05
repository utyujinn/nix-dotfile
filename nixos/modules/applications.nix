{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
  };
  programs.steam.enable = true;
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

    ####################
    # Web Browsers     #
    ####################
    vivaldi

    ####################
    # Office & Docs    #
    ####################
    libreoffice
    xournalpp
    obsidian
    kdePackages.okular
    texstudio
    texlive.combined.scheme-full
    #rnote
    #anki

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

    ####################
    # Gaming & Retro   #
    ####################
    protontricks
    wla-dx
    mesen

    ####################
    # Tmp              #
    ####################

  ];
}

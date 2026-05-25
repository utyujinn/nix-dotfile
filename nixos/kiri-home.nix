{ config, pkgs, lib, ... }:
{
  home = {
    username = "utyujin";
    homeDirectory = "/home/utyujin";
    stateVersion = "24.11";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = config.gtk.theme;
  };

  systemd.user.sessionVariables = config.home.sessionVariables;

  imports = [
    ./home/vim.nix
    ./home/zsh.nix
    ./home/yazi.nix
    ./home/alacritty.nix
    ./home/git.nix
    ./home/rclone.nix
    ./home/tmux.nix
    ./home/misc.nix
    ./home/claude.nix
  ];

  services.mako = {
    enable = true;
    settings = {
      background-color = "#285577";
      border-color = "#4c7899";
      default-timeout = 5000;
      border-radius = 4;
    };
  };

  programs.home-manager.enable = true;
}

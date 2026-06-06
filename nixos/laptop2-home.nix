{ config, pkgs, lib, inputs, ... }:
{
  home = {
    username = "utyujin";
    homeDirectory = "/home/utyujin";
    stateVersion = "24.11";
  };

  # espanso.nix の X11 設定を Wayland で上書き
  home.sessionVariables.ESPANSO_BACKEND = lib.mkForce "Wayland";

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
    ./home/sway.nix
    ./home/yazi.nix
    ./home/alacritty.nix
    ./home/git.nix
    ./home/rclone.nix
    ./home/espanso.nix
    ./home/tmux.nix
    ./home/cursor.nix
    ./home/misc.nix
    ./home/claude.nix
    ./home/albert.nix
  ];

  programs.home-manager.enable = true;
}

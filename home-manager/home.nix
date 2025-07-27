{ config, pkgs, inputs, ... }:
{
  home = {
    username = "utyujin";
    homeDirectory = "/home/utyujin";
    stateVersion = "24.11";
    packages = with pkgs; [];
    file = {};
  };
  imports = [
    ./modules/vim.nix
    ./modules/zsh.nix
    ./modules/i3.nix
    ./modules/yazi.nix
    ./modules/alacritty.nix
    ./modules/git.nix
    ./modules/xkeysnail.nix
    ./modules/rclone.nix
    ./modules/xournalpp.nix
  ];
  programs.home-manager.enable = true;
}

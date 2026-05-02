{ config, pkgs, inputs, ... }:
{
  home = {
    username = "unia";
    homeDirectory = "/home/unia";
    stateVersion = "25.11";
    packages = with pkgs; [];
    file = {};
  };
  imports = [
    ./home/vim.nix
    ./home/zsh.nix
    ./home/yazi.nix
    ./home/git.nix
    ./home/rclone.nix
  ];
  programs.home-manager.enable = true;
}

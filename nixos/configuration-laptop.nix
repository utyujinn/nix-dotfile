{ config, pkgs, ... }:
{
  system.stateVersion = "24.11";
  imports =[
    ./hardware-configuration.nix
    ./custom-packages.nix
    ./modules/locale.nix
    ./modules/user.nix
    ./modules/misc.nix
    ./modules/font.nix
    ./modules/input.nix
    ./modules/network.nix
    ./modules/audio.nix
    ./modules/applications.nix
    ./modules/i3.nix
  ];
}

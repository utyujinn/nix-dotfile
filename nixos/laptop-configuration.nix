{ config, pkgs, ... }:
{
  system.stateVersion = "24.11";
  home-manager.users.utyujin = import ./home-manager/home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-bak";
  imports =[
    ./hardware-configuration.nix
    ./modules/custom-packages.nix
    ./modules/locale.nix
    ./modules/user.nix
    ./modules/misc.nix
    ./modules/font.nix
    ./modules/input.nix
    ./modules/network.nix
    ./modules/audio.nix
    ./modules/applications.nix
    ./modules/i3.nix
    ./modules/pen.nix
  ];
}

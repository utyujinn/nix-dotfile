{ config, pkgs, ...}:
{
  networking.wireless.iwd.enable=true;
  hardware.bluetooth.enable=true;
}

{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    xorg.xrandr
    xorg.xinit
    xorg.xf86inputlibinput
    at-spi2-atk
  ];
  services = {
    libinput.enable = true;
    displayManager.defaultSession = "none+i3";
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager = {
        startx.enable = true;
        #defaultSession = "none+i3";
        #lightdm.enable = false;
      };
      #libinput.enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
        ];
      };
    };
  };
}

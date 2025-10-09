{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    xorg.xrandr
    xorg.xinit
    arandr
    autorandr
    xorg.xf86inputlibinput
    at-spi2-core
    feh
    rofi
    # アニメーション用コンポジタ
    picom
    # i3のアニメーション拡張
    i3-auto-layout
    # ワークスペース切り替えスクリプト用
    jq
  ];
  services = {
    libinput.enable = true;
    displayManager.defaultSession = "none+i3";
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager = {
        startx.enable = true;
      };
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

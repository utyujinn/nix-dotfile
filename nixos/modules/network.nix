{ config, pkgs, ...}:
{

  networking.firewall = {
    enable = true; # ファイアウォールを有効にする (デフォルトで有効です)
    allowedTCPPorts = [ 3000 ]; # ここに開放したいTCPポート番号を追加
    # allowedUDPPorts = [ ... ]; # UDPポートを開けたい場合はこちら
  };
  
  networking.wireless.iwd.enable=true;
  hardware.bluetooth.enable=true;
}

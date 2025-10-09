{ config, pkgs, lib, ...}:
{
  # Wacom タブレット/ペン入力の設定
  services.xserver.wacom.enable = true;
  environment.systemPackages = with pkgs; [
    xf86_input_wacom
    libwacom
    
    # 完全リセット用スクリプト（root権限）
    (writeShellScriptBin "wacom-usb-reset" ''
      if [ "$EUID" -ne 0 ]; then
        echo "This script requires root privileges. Use: sudo wacom-usb-reset"
        exit 1
      fi
      
      echo "=== Wacom USB Reset (Root) ==="
      
      # Wacom USBデバイスを見つけてリセット
      for device in /sys/bus/usb/devices/*/idVendor; do
        if [ -f "$device" ] && [ "$(cat "$device" 2>/dev/null)" = "056a" ]; then
          device_path=$(dirname "$device")
          product_file="$device_path/idProduct"
          if [ -f "$product_file" ] && [ "$(cat "$product_file" 2>/dev/null)" = "52b0" ]; then
            echo "Found Wacom HID 52B0 at $device_path"
            echo "Resetting USB device..."
            echo 0 > "$device_path/authorized"
            sleep 2
            echo 1 > "$device_path/authorized"
            echo "USB reset complete"
            break
          fi
        fi
      done
      
      # カーネルモジュールのリロード
      echo "Reloading wacom kernel module..."
      ${pkgs.kmod}/bin/modprobe -r wacom 2>/dev/null || true
      sleep 1
      ${pkgs.kmod}/bin/modprobe wacom
      
      echo "=== USB reset complete ==="
    '')
  ];

  # Wacom ペン復旧用ユーザーサービス
  home-manager.users.utyujin = {
    systemd.user.services.wacom-pen-recovery = {
      Unit = {
        Description = "Wacom pen input recovery service";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash ${pkgs.writeScript "wacom-recovery" ''
          export DISPLAY=''${DISPLAY:-:0}
          if ! ${pkgs.xorg.xinput}/bin/xinput list | ${pkgs.gnugrep}/bin/grep -q "Wacom.*Pen"; then
            echo "Wacom pen not detected, attempting recovery..."
            ${pkgs.xorg.xinput}/bin/xinput reattach "Wacom HID 52B0 Pen Pen" 2 2>/dev/null || true
            ${pkgs.xorg.xinput}/bin/xinput enable "Wacom HID 52B0 Pen Pen" 2>/dev/null || true
          fi
        ''}";
        RemainAfterExit = true;
      };
    };

    systemd.user.timers.wacom-pen-watchdog = {
      Unit = {
        Description = "Wacom pen watchdog timer";
      };
      Timer = {
        OnBootSec = "2min";
        OnUnitActiveSec = "5min";
        Unit = "wacom-pen-recovery.service";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
}
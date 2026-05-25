{ config, pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "pkill rofi; ${pkgs.rofi}/bin/rofi -show drun";

      fonts = {
        names = [ "UDEV Gothic" ];
        size = 15.0;
      };

      defaultWorkspace = "workspace number 1";

      input = {
        "type:keyboard" = {
          xkb_layout = "us";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          dwt = "enabled";
        };
        "type:touch" = {
          map_to_output = "eDP-1";
        };
        "type:tablet_tool" = {
          map_to_output = "eDP-1";
        };
      };

      keybindings = lib.mkOptionDefault {
        # Apps
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+q"      = "kill";
        "${modifier}+d"      = "exec pkill rofi; ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+Shift+f" = "exec sh -c 'FILE=$(${pkgs.fd}/bin/fd . --type f --hidden --exclude .git --exclude .cache --exclude node_modules --search-path \"$HOME\" | ${pkgs.rofi}/bin/rofi -dmenu -i -p \" Files\" -theme ${config.xdg.configHome}/rofi/tablet-theme.rasi) && [ -n \"$FILE\" ] && xdg-open \"$FILE\"'";
        "${modifier}+v"      = "exec pavucontrol";
        "${modifier}+b"      = "exec vivaldi";
        "${modifier}+c"      = "exec code";
        "${modifier}+o"      = "exec obsidian";
        "${modifier}+e"      = "exec ${terminal} -e yazi";
        "${modifier}+x"      = "exec xournalpp";
        # OSK toggle
        "${modifier}+k"      = "exec pkill wvkbd-mobintl || ${pkgs.wvkbd}/bin/wvkbd-mobintl --landscape";

        # Layout
        "${modifier}+f"            = "fullscreen toggle";
        "${modifier}+t"            = "floating toggle";
        "${modifier}+s"            = "layout stacking";
        "${modifier}+w"            = "layout tabbed";
        "${modifier}+a"            = "focus parent";
        "${modifier}+r"            = "mode resize";
        "${modifier}+Shift+space"  = "floating toggle";

        # Focus
        "${modifier}+Left"  = "focus left";
        "${modifier}+Down"  = "focus down";
        "${modifier}+Up"    = "focus up";
        "${modifier}+Right" = "focus right";

        # Move
        "${modifier}+Shift+Left"  = "move left";
        "${modifier}+Shift+Down"  = "move down";
        "${modifier}+Shift+Up"    = "move up";
        "${modifier}+Shift+Right" = "move right";
        "${modifier}+Shift+h"     = "move left";
        "${modifier}+Shift+j"     = "move down";
        "${modifier}+Shift+k"     = "move up";
        "${modifier}+Shift+l"     = "move right";

        # Sway control
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'Exit sway?' -B 'Yes, exit' 'swaymsg exit'";

        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Hardware keys
        "XF86AudioRaiseVolume"  = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume"  = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute"         = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute"      = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessUp"   = "exec brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";

        # Screenshot → clipboard
        "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        # Screenshot → file
        "Shift+Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" $HOME/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png";

        # Lock
        "${modifier}+Shift+x" = "exec swaylock -f -c 000000";
      };

      modes = {
        resize = {
          h      = "resize shrink width 10 px";
          j      = "resize grow height 10 px";
          k      = "resize shrink height 10 px";
          l      = "resize grow width 10 px";
          Left   = "resize shrink width 10 px";
          Down   = "resize grow height 10 px";
          Up     = "resize shrink height 10 px";
          Right  = "resize grow width 10 px";
          Return = "mode default";
          Escape = "mode default";
          "${modifier}+r" = "mode default";
        };
      };

      # nwg-panel がパネルを担当するので waybar は無効化
      bars = [];

      floating.criteria = [
        { app_id = "pavucontrol"; }
        { title = "^(Open|Save).*"; }
      ];

      startup = [
        { command = "fcitx5 -d --replace"; always = true; }
        { command = "${pkgs.mako}/bin/mako"; always = true; }
        { command = "${pkgs.awww}/bin/awww-daemon"; }
        {
          command = "${pkgs.bash}/bin/bash -c 'sleep 1 && ${pkgs.awww}/bin/awww img $(find $HOME/Pictures/wallpapers -name \"*.jpg\" -o -name \"*.jpeg\" -o -name \"*.png\" 2>/dev/null | shuf -n1) --transition-type fade'";
        }
        { command = "espanso service start --unmanaged"; always = true; }
        # Tablet: パネル・ドック
        { command = "${pkgs.nwg-panel}/bin/nwg-panel"; always = true; }
        { command = "${pkgs.nwg-dock}/bin/nwg-dock -p bottom -i 52 -s dot -nows -nolauncher"; always = true; }
        # Tablet: 自動画面回転 (iio-sensor-proxy 経由)
        { command = "${pkgs.rot8}/bin/rot8 --display eDP-1 --sleep 500"; }
        # Tablet: タッチスクリーンジェスチャー
        # 3本指左→右: ひとつ前のワークスペース
        # 3本指右→左: 次のワークスペース
        # 3本指下→上: nwg-drawer を開く
        # 2本指下→上: OSK 表示/非表示
        {
          command = "${pkgs.lisgd}/bin/lisgd -g '3,LR,0.15,0.5,0,swaymsg workspace prev_on_output' -g '3,RL,0.15,0.5,0,swaymsg workspace next_on_output' -g '3,DU,0.15,0.5,0,${pkgs.nwg-drawer}/bin/nwg-drawer' -g '2,DU,0.15,0.5,0,pkill wvkbd-mobintl || ${pkgs.wvkbd}/bin/wvkbd-mobintl --landscape'";
        }
      ];
    };

    extraConfig = ''
      default_border none
      tiling_drag enable

      # タッチパッドの3本指スワイプ (Sway ネイティブ)
      bindgesture swipe:3:right workspace prev_on_output
      bindgesture swipe:3:left  workspace next_on_output

      for_window [app_id="pavucontrol"] floating enable, resize set 600 400, move position 1300 600
    '';
  };

  # nwg-panel メイン設定
  xdg.configFile."nwg-panel/config".text = builtins.toJSON [
    {
      name = "panel-top";
      output = "";
      layer = "top";
      position = "top";
      height = 44;
      "margin-top" = 0;
      "margin-bottom" = 0;
      "padding-horizontal" = 6;
      "padding-vertical" = 0;
      spacing = 6;
      "items-padding" = 0;
      icons = "light";
      "css-name" = "panel-top";
      "modules-left" = [ "sway-workspaces" ];
      "modules-center" = [ "clock" ];
      controls = "right";
      "modules-right" = [ "tray" ];
      "sway-workspaces" = {
        numbers = [ 1 2 3 4 5 6 7 8 9 10 ];
        "show-icon" = false;
        "image-size" = 16;
        "show-name" = true;
        "name-length" = 40;
      };
      clock = {
        format = "%H:%M  %a %d";
        interval = 30;
      };
      "controls-settings" = {
        "window-width" = 0;
        interval = 1;
        "icon-size" = 24;
        "hover-cursor" = "pointer";
        icons = "light";
        "css-name" = "controls-window";
        "custom-items" = [
          { name = "WiFi"; icon = "network-wireless"; cmd = "iwgtk"; }
        ];
        menu = {};
      };
    }
  ];

  # nwg-panel コントロールポップアップ設定
  xdg.configFile."nwg-panel/controls".text = builtins.toJSON {
    "show-values" = true;
    "icon-size" = 24;
    interval = 1;
    "with-net" = false;
    "with-bluetooth" = true;
    "with-battery" = true;
    "battery-levels" = [];
    commands = {
      "screen-lock" = "swaylock -f -c 000000";
      reboot = "systemctl reboot";
      poweroff = "systemctl poweroff";
      logout = "swaymsg exit";
    };
  };

  # nwg-panel スタイル (ダークテーマ)
  xdg.configFile."nwg-panel/style.css".text = ''
    * {
      font-family: "UDEV Gothic", monospace;
      font-size: 14px;
    }
    window {
      background-color: rgba(0, 0, 0, 0.85);
      color: #ffffff;
    }
    button {
      background: none;
      border: none;
      color: #ffffff;
      padding: 4px 10px;
    }
    button:hover {
      background-color: rgba(255, 255, 255, 0.15);
      border-radius: 4px;
    }
    #clock {
      padding: 0 16px;
      color: #ffffff;
    }
    #workspace-button {
      min-width: 40px;
      min-height: 36px;
      color: #888888;
      border-bottom: 2px solid transparent;
    }
    #workspace-button.focused,
    #workspace-button:checked {
      color: #ffffff;
      border-bottom: 2px solid #4c7899;
    }
    #controls-label {
      padding: 0 10px;
    }
  '';

  # nwg-dock ピン留めアプリ (デスクトップエントリ名)
  xdg.dataFile."nwg-dock/pinned".text = ''
    vivaldi
    Alacritty
    pcmanfm
    obsidian
    krita
    com.github.xournalpp.xournalpp
  '';

  services.mako = {
    enable = true;
    settings = {
      background-color = "#285577";
      border-color = "#4c7899";
      default-timeout = 5000;
      border-radius = 4;
    };
  };

  services.kanshi = {
    enable = true;
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "swaylock -f -c 000000"; }
      { timeout = 600; command = "swaymsg 'output * power off'";
        resumeCommand = "swaymsg 'output * power on'"; }
    ];
    events = {
      before-sleep = "swaylock -f -c 000000";
    };
  };
}

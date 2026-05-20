{ config, pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show drun";

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
        "type:tablet_tool" = {
          map_to_output = "eDP-1";
        };
      };

      keybindings = lib.mkOptionDefault {
        # Apps
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+q"      = "kill";
        "${modifier}+d"      = "exec ${menu}";
        "${modifier}+v"      = "exec pavucontrol";
        "${modifier}+b"      = "exec vivaldi";
        "${modifier}+c"      = "exec code";
        "${modifier}+o"      = "exec obsidian";
        "${modifier}+e"      = "exec ${terminal} -e yazi";
        "${modifier}+x"      = "exec xournalpp";

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
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute"        = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute"     = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessUp"  = "exec brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";

        # Screenshot → クリップボードにコピー
        "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
        # Screenshot → ファイルに保存
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

      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      floating.criteria = [
        { app_id = "pavucontrol"; }
        { app_id = "Onboard"; }
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
      ];
    };

    extraConfig = ''
      default_border none
      tiling_drag enable

      for_window [app_id="pavucontrol"] floating enable, resize set 600 400, move position 1300 600
      for_window [app_id="Onboard"]     floating enable
    '';
  };

  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "bottom";
      height = 28;
      modules-left   = [ "sway/workspaces" "sway/mode" ];
      modules-center = [ "sway/window" ];
      modules-right  = [ "pulseaudio" "network" "backlight" "battery" "clock" ];

      "sway/workspaces".disable-scroll = true;
      "sway/window".max-length = 60;

      clock.format = "{:%H:%M  %Y-%m-%d}";

      battery = {
        format       = "BAT {capacity}%";
        format-charging = "CHR {capacity}%";
        format-plugged  = "PLG {capacity}%";
        warning  = 30;
        critical = 15;
      };

      backlight = {
        format = "BRI {percent}%";
      };

      pulseaudio = {
        format       = "VOL {volume}%";
        format-muted = "MUTED";
        on-click     = "pavucontrol";
      };

      network = {
        format-wifi        = "{essid} ({signalStrength}%)";
        format-ethernet    = "ETH {ifname}";
        format-disconnected = "disconnected";
        tooltip-format-wifi = "{ipAddr}";
      };
    }];

    style = ''
      * {
        font-family: "UDEV Gothic", monospace;
        font-size: 13px;
        min-height: 0;
      }
      window#waybar {
        background-color: rgba(0, 0, 0, 0.85);
        color: #ffffff;
      }
      #workspaces button {
        padding: 0 8px;
        color: #888888;
        border-bottom: 2px solid transparent;
      }
      #workspaces button.focused {
        color: #ffffff;
        border-bottom: 2px solid #4c7899;
      }
      #workspaces button:hover {
        background-color: rgba(255, 255, 255, 0.1);
      }
      #clock, #battery, #backlight, #pulseaudio, #network {
        padding: 0 12px;
      }
      #battery.warning  { color: #ffaa00; }
      #battery.critical { color: #ff5555; }
    '';
  };

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

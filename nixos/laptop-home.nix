{ config, pkgs, inputs, ... }:
{
  home = {
    username = "utyujin";
    homeDirectory = "/home/utyujin";
    stateVersion = "24.11";
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = config.gtk.theme;
  };
  
  systemd.user.sessionVariables = config.home.sessionVariables;
    
    
  systemd.user.services.wacom-pen-recovery = {
    Unit = {
      Description = "Wacom pen input recovery service";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${pkgs.writeScript "wacom-recovery" ''
        export DISPLAY=''${DISPLAY:-:0}
        if ! ${pkgs.xinput}/bin/xinput list | ${pkgs.gnugrep}/bin/grep -q "Wacom.*Pen"; then
          echo "Wacom pen not detected, attempting recovery..."
          ${pkgs.xinput}/bin/xinput reattach "Wacom HID 52B0 Pen Pen" 2 2>/dev/null || true
          ${pkgs.xinput}/bin/xinput enable "Wacom HID 52B0 Pen Pen" 2>/dev/null || true
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

  imports = [
    ./home/vim.nix
    ./home/zsh.nix
    ./home/i3.nix
    ./home/yazi.nix
    ./home/alacritty.nix
    ./home/git.nix
    ./home/xkeysnail.nix
    ./home/rclone.nix
    ./home/espanso.nix
    ./home/tmux.nix
    ./home/cursor.nix
    ./home/misc.nix
    ./home/claude.nix
  ];

  programs.home-manager.enable = true;
}

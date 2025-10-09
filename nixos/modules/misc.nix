{ config, pkgs, lib, ...}:
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes" ;


  security.sudo = {
    wheelNeedsPassword = false;
    extraRules = [
      {
        users = [ "utyujin" ];
        commands = [
        {
          command = "ALL";
          options = [ "SETENV" "NOPASSWD" ];
        }
        ];
      }
    ];
  };

  #services.logind.settings.Login = ''
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  services.tlp = {
    enable = true;
    settings = {
      RESTORE_DEVICE_STATE_ON_STARTUP = 0;
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
    };
  };
  services.touchegg.enable = true;


  #services.fprintd.enable = true;
  #services.fprintd.tod.enable = true;
  #services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  environment.sessionVariables = {
  PATH = "$PATH:.";
  XDG_DATA_DIRS = lib.mkForce (
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:" +
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:" +
    "${pkgs.gtk4}/share/gsettings-schemas/${pkgs.gtk4.name}:" +
    "${pkgs.gtk4}/share:" +
    "${pkgs.glib}/share/glib-2.0/schemas:" +
    "$XDG_DATA_DIRS"
  );
};


  #services.dbus.enable = true;
    #xdg.portal = {
      #enable = true;
      #extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];

    # 一部のWMでは、特定のバックエンドも必要になる場合があります。
    #};

  #programs.dconf.enable = true;

#darktheme
  home-manager.users.utyujin = {
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
    };

    # Wayland, X, etc. support for session vars
    systemd.user.sessionVariables = config.home-manager.users.utyujin.home.sessionVariables;

  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

}

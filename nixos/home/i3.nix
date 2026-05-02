{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../dotfile/i3 + "/${name}"; };
    in
    {
      "i3/config" = s "config";
      "picom/picom.conf" = s "picom.conf";
      "i3status/config" = s "i3status.conf";
      "autorandr/postswitch" = {
        source = ../dotfile/i3 + "/postswitch";
        executable = true;
      };
    };

  home.file.".xinitrc" = {
    source = ../dotfile/i3/xinitrc;
  };
}

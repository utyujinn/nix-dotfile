{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../apps/i3 + "/${name}"; };
    in
    {
      "i3/config" = s "config";
      "picom/picom.conf" = s "picom.conf";
      "i3status/config" = s "i3status.conf";
      "autorandr/postswitch" = {
        source = ../apps/i3 + "/postswitch";
        executable = true;
      };
      "i3/workspace-animation.sh" = {
        source = ../apps/i3 + "/workspace-animation.sh";
        executable = true;
      };
    };

  home.file.".xinitrc" = {
    source = ../apps/i3/xinitrc;
  };
}

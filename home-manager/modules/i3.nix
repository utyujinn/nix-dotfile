{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../apps/i3 + "/${name}"; };
    in
    {
      "i3/config" = s "config";
      "autorandr/postswitch" = {
        source = ../apps/i3 + "/postswitch";
        executable = true;
      };
    };

  home.file.".xinitrc" = {
    source = ../apps/i3/xinitrc;
  };
}

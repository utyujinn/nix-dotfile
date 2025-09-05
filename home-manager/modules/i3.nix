{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../apps/i3 + "/${name}"; };
    in
    {
      "i3/config" = s "config";
    };

  home.file.".xinitrc" = {
    source = ../apps/i3/xinitrc;
  };
}

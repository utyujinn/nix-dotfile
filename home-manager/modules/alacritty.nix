{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../apps/alacritty + "/${name}"; };
    in
    {
      "alacritty/alacritty.toml" = s "alacritty.toml";
    };
}

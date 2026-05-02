{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../dotfile/alacritty + "/${name}"; };
    in
    {
      "alacritty/alacritty.toml" = s "alacritty.toml";
    };
}

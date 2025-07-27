{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../../alacritty + "/${name}"; };
    in
    {
      "alacritty/alacritty.toml" = s "alacritty.toml";
    };
}

{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../../i3 + "/${name}"; };
    in
    {
      "i3/config" = s "config";
    };
}

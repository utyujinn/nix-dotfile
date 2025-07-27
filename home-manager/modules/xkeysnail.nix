{ config, pkgs, inputs, ...}:
{
  xdg.configFile =
    let
      s = name: { source = ../../xkeysnail + "/${name}"; };
    in
    {
      # entry files
      "xkeysnail/config.py" = s "config.py";
    };
}
